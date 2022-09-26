class RecordsController < ApplicationController

  def show

    @record = Record.find(params[:id])
    authorize(@record)
    quizz_answer_id = @record.quizz_answer_id
    quizz_level = @record.quizz_level
    user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id)

    @number_of_questions = @record.question_answers.count
    @synthesis = synthesis(user_answers)

    # would be a matter if a new other record is set (the display would change), then come back to this page / url, but unlikely to happen
    @is_new_record = (find_best_user_record(quizz_level) == @record)

    # need to store unlocked items in cookie if page reload ?
    if @is_new_record
      @unlocked_items = unlocked_items_calculation(@record)
      set_new_record(@record)
    end

    @all_best_records = BestRecord.where(quizz_level: quizz_level).joins(:record).order(completion: :desc, seconds_duration: :asc, milliseconds_duration: :asc)

    @user_ranking = @all_best_records.index{ |best_record| best_record.record.user == current_user} + 1

    @all_records_count =  @all_best_records.count

    @all_best_records = @all_best_records.paginate(page: params[:page], per_page: 10)

    @xp_win = xp_win_calculation(@record, @is_new_record, quizz_level)
    @gold_win = gold_win_calculation(@record)
    @flashcards_unlocked_count = flashcards_unlocked_calculation(@record.quizz)
    # Need to check if the record add already been dealt with

    user_levels_unlocked_count = 0
    if !@record.dealt_with
      @former_xp = current_user.xp
      @former_level = current_user.level
      current_user.gold += @gold_win
      user_levels_unlocked = leveling_calculation(@xp_win)
      user_levels_unlocked_count = user_levels_unlocked.size
      @unlocked_items[:user_levels] = user_levels_unlocked if user_levels_unlocked_count > 0
      @record.dealt_with = true
      @record.save!
    end

    @total_unlocked_items = (@unlocked_items ? @unlocked_items.count{ |k,v| v != nil && k != :user_levels} : 0) + user_levels_unlocked_count

    respond_to do |format|
      format.html
      if params[:quizz_id]
        # Called by leaderboard pagination from challenge card (with quizz name)
        @quizz_id = params[:quizz_id]
        @quizz = Quizz.find(@quizz_id)
        format.json {render 'quizz_leaderboard'}
      else
        # called by leaderboard card
        format.json {render 'level_leaderboard'}
      end
    end

  end

  # BACK END CHECK NUMBER OF ANSWER = NUMBER OF QUESTION + TIME  (time_difference_in_milliseconds?)
  # ADD STRONG PARAMS
  # check thate quizz answers are quizz answer from the user / set to dealt with when done ?
  def create
    user = current_user
    data = JSON.parse(params["json"])
    quizz_answer_id = data["quizz_answer_id"].to_i
    # seconds_duration = data["final_time_seconds"]
    # milliseconds_duration = data["final_time_tens"]

    quizz_answer = QuizzAnswer.find(quizz_answer_id)
    user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id).order(:created_at)
    back_time = (user_answers.last.created_at - quizz_answer.created_at) / 1.seconds

    back_time_ms = back_time.modulo(1) * 10
    back_time_sec = back_time.to_i

    quizz_level = quizz_answer.quizz_level

    @record = Record.new(
      user: user,
      quizz_level: quizz_level,
      seconds_duration: back_time_sec,
      milliseconds_duration: back_time_ms,
      completion: completion_calculation(user_answers, back_time_sec, back_time_ms),
      score_percentage: score_percentage_calculation(user_answers),
      crown_or_sphere: quizz_level.crown_or_sphere,
      quizz_answer_id: quizz_answer_id,
      dealt_with: false
      )

    authorize(@record)

    if check_user_answer(quizz_answer_id, quizz_level)
        @record.save!
        respond_to do |format|
          format.json
        end
      else
        flash[:alert] = "Le record n'a pas pu être sauvé, si besoin, merci d'utiliser le formulaire de concact pour remonter un bug"
        p "subbtheme id : #{quizz_level.category.subtheme}"
        p "window.location = subtheme_path(quizz_level.category.subtheme : #{subtheme_path(quizz_level.category.subtheme)}"
        respond_to do |format|
          format.json { render json: { location: subtheme_path(quizz_level.category.subtheme) } }
        end
      end


  end

  private

    # check that quizz answer has been done by the user
    # check time is not < 110% of back calculation
    # check that time is not < 1 sec / question (time of tempo from a question to another)
    def check_user_answer(quizz_answer_id, quizz_level)
      quizz_answer = QuizzAnswer.find(quizz_answer_id)
      return nil if quizz_answer.user != current_user

      user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id).order(:created_at)
      back_time_difference = user_answers.last.created_at - quizz_answer.created_at
      quizz_question_answers_count = quizz_level.question_answers.count

      return nil if user_answers.count != quizz_question_answers_count

      return nil if back_time_difference < quizz_question_answers_count * 0.1

      true
    end

    def flashcards_unlocked_calculation(quizz)
      count = 0
      quizz.question_answers.each do |question_answer|
        if !current_user.flashcards.find_by(question_answers: question_answer)
          count += 1
          flashcard = Flashcard.new({
            ease_factor: Flashcard::STARTING_EASE,
            repetition: 0,
            interval: 0,
            day_of_last_repetition: "",
            mistake_count: 0,
            question_answer: question_answer,
            day_of_next_repetition: DateTime.current,
            status: "learning",
            user: current_user,
            steps_index: 0,
            theme: quizz.theme,
            category: quizz.category,
            unlocked: true
          })
          flashcard.save!
        end
      end
      count
    end

    def leveling_calculation(xp_win, next_levels_unlocked=[])
      user = current_user
      next_level = Level.find_by(level: user.level.level + 1)
      if xp_win + user.xp < next_level.required_xp
        user.xp += xp_win
        user.save
        return next_levels_unlocked
      else
        user.xp = xp_win + user.xp - next_level.required_xp
        user.level = next_level
        user.save
        next_levels_unlocked << next_level
        leveling_calculation(0, next_levels_unlocked)
      end
    end

    def set_new_record(record)
      current_record = record.quizz_level.best_records.joins(:record).find_by(records: {user: current_user})
      if current_record
        current_record.record = record
      else
        current_record = BestRecord.new(quizz_level: record.quizz_level, record: record, theme: record.theme)
      end
      current_record.save!
    end

    def synthesis(user_answers)
      @synthesis = user_answers.includes([:question_answer]).map do |user_answer|
        question_synthesis = {}
        question_answer = user_answer.question_answer
        question_synthesis[:question] = question_answer.question
        question_synthesis[:answer] = question_answer.answer
        question_synthesis[:user_answer]= user_answer.answer
        question_synthesis[:is_good] = (user_answer.answer_id == question_answer.id)
        question_synthesis
      end
    end

    def good_and_bad_answers_count(user_answers)
      good_answer_count = user_answers.count{ |user_answer| user_answer.answer_id == user_answer.question_answer.id }
      bad_answer_count = user_answers.count{ |user_answer| user_answer.answer_id != user_answer.question_answer.id }
      {good: good_answer_count, bad: bad_answer_count}
    end

    def score_percentage_calculation(user_answers)
      answers_count = good_and_bad_answers_count(user_answers)
      (answers_count[:good].to_f) / (answers_count[:good] + answers_count[:bad]) * 100
    end

    def completion_calculation(answers, seconds, milliseconds)
      #number of question
      answers_count = good_and_bad_answers_count(answers)
      total_questions = answers_count[:bad] + answers_count[:good]
      one_crown_authorized_mitakes = 1
      time = time_to_ms(seconds, milliseconds)
      threecrowns_autorized_time = time_to_ms(3, 0) * total_questions
      completion = 0
      completion += 1 if answers_count[:bad] <= one_crown_authorized_mitakes
      completion += 1 if answers_count[:bad] == 0
      completion += 1 if answers_count[:bad] == 0 && time < threecrowns_autorized_time
      completion
    end

    def time_to_ms(s, ms)
      s * 1000 + ms
    end

    def find_best_user_record(quizz_level)
      current_user.records.where(quizz_level: quizz_level).order(completion: :desc, seconds_duration: :asc, milliseconds_duration: :asc).first
    end

    def find_past_best_user_record(quizz_level)
      current_user.records.where(quizz_level: quizz_level).order(completion: :desc, seconds_duration: :asc, milliseconds_duration: :asc).limit(1).offset(1)[0]
    end

    # no xp if no more crowns won
    # @past_best_record == nil if it is the first record
    # If several stars difference with no record, add all coef
    # ADD VALIDATION ON NAME OF QUIZZ LEVEL TO ENSURE THAT WE CAN FIND THE COEF
    def xp_win_calculation(record, is_new_record, quizz_level)
      record_completion = record.completion
      return 0 if record_completion == 0 || !is_new_record

      past_best_user_record = find_past_best_user_record(quizz_level)
      if past_best_user_record
        past_best_record_completion = past_best_user_record.completion
        return 0 if record_completion <= past_best_record_completion

      else
        past_best_record_completion = 0
      end
      difficulty_coefs= { Facile: 1, Moyen: 2, Difficile: 5 }
      crown_coefs = [1, 2, 3]
      total_coef = 0
      total_coef = crown_coefs[past_best_record_completion, record_completion - past_best_record_completion].sum
      total_coef *= difficulty_coefs[record.quizz_level.name.to_sym]
      total_coef * record.question_answers.count
    end

    # crown * difficulty * score_percentage * number_of_questions
    def gold_win_calculation(record)
      difficulty_coefs = { Facile: 1, Moyen: 2, Difficile: 5 }
      crown_coefs = [1, 2, 3, 5]
      (crown_coefs[record.completion] * difficulty_coefs[record.quizz_level.name.to_sym] * record.question_answers.count * record.score_percentage / 100).round
    end

    #Nothing unlocked if no crown
    #Nothing unlock for level "difficile"
    #Check if it is the last quizz of the category
    #Also unlock level 1 of the unlocked quizz
    #NEED TO CHECK IF ALREADY UNLOCKED
    def unlocked_items_calculation(record)

      unlocked_items = {}
      return nil if record.completion == 0

      quizz_level_name = record.quizz_level.name
      if quizz_level_name == "Facile" || quizz_level_name == "Moyen"
        quizz = record.quizz
        quizz_level_name_to_unlock = (quizz_level_name == "Facile" ? "Moyen" : "Difficile")
        unlocked_items[:quizz_level] = unlock_quizz_level(quizz, quizz_level_name_to_unlock)
        if quizz_level_name == "Moyen" && record.completion >= 2
            all_category_quizzs = quizz.category.quizzs
            number_of_quizzs = all_category_quizzs.count
          if quizz.ordering != number_of_quizzs
            quizz_to_unlock = quizz.category.quizzs.find_by(ordering: quizz.ordering + 1)
            unlocked_items[:quizz] = unlock_quizz(quizz_to_unlock)
            unlock_quizz_level(quizz_to_unlock, "Facile")
          else
            if (unlocked_items[:category] =  unlock_category(quizz.category))
              unlocked_items[:theme_level_and_children] = unlock_theme_level_and_children(unlocked_items[:category])
            end
          end
        end
      end
      unlocked_items
    end

    def unlock_quizz_level(quizz, name)
      quizz_level_to_unlock = QuizzLevel.find_by(quizz: quizz, name: name)
      quizz_level_progress_to_unlock = current_user.quizz_level_progresses.find_by(quizz_level: quizz_level_to_unlock)

      return nil if !quizz_level_progress_to_unlock

      return nil if quizz_level_progress_to_unlock.unlocked

      quizz_level_progress_to_unlock.unlocked = true
      quizz_level_progress_to_unlock.save!
      quizz_level_to_unlock
    end

    def unlock_quizz(quizz)
      quizz_progress_to_unlock = current_user.quizz_progresses.find_by(quizz: quizz)

      return nil if !quizz_progress_to_unlock

      return nil if quizz_progress_to_unlock.unlocked

      quizz_progress_to_unlock.unlocked = true
      quizz_progress_to_unlock.save!
      quizz
    end

    def unlock_category(category)
      category_progress_to_unlock = current_user.category_progresses.find_by(category: category)

      return nil if !category_progress_to_unlock

      return nil if category_progress_to_unlock.unlocked

      category_progress_to_unlock.unlocked = true
      category_progress_to_unlock.save!
      category
    end

    def unlock_theme_level(theme_level)
      theme_level_progress_to_unlock = current_user.theme_level_progresses.find_by(theme_level: theme_level)

      return nil if !theme_level_progress_to_unlock

      return nil if theme_level_progress_to_unlock.unlocked

      theme_level_progress_to_unlock.unlocked = true
      theme_level_progress_to_unlock.save!
      theme_level

    end

    def unlock_subtheme(subtheme)
      subtheme_progress_to_unlock = current_user.subtheme_progresses.find_by(subtheme: subtheme)

      return nil if !subtheme_progress_to_unlock

      return nil if subtheme_progress_to_unlock.unlocked

      subtheme_progress_to_unlock.unlocked = true
      subtheme_progress_to_unlock.save!
      subtheme
    end

    # check if all badges of a categoy have been unlocked
    # unlock new theme level, and first quizz of each subtheme of the corresponding category
    #Theme level can already be unlocked, but still needed to unlocked new theme level, and first quizz of each subtheme of the corresponding category
    def unlock_theme_level_and_children(category)
      theme_level = category.theme_level
      subthemes = theme_level.subthemes
      categories = subthemes.map { |subtheme| Category.find_by(subtheme: subtheme, name: category.name)}

      categories_progresses = categories.map { |category| current_user.category_progresses.find_by(category: category) }
      if categories_progresses.all? {|category_progress| category_progress.unlocked}
        theme_level_to_unlock = ThemeLevel.find_by(level: theme_level.level + 1)

        theme_level_and_children = {}

        theme_level_and_children[:theme_level] = unlock_theme_level(theme_level_to_unlock)
        subthemes_to_unlock = theme_level_to_unlock.subthemes

        theme_level_and_children[:subthemes] = []
        subthemes_to_unlock.each {|subtheme_to_unlock| theme_level_and_children[:subthemes] << unlock_subtheme(subtheme_to_unlock)}
        categories_to_unlock = subthemes_to_unlock.map { |subtheme_to_unlock| Category.find_by(subtheme: subtheme_to_unlock, name: category.name)}

        theme_level_and_children[:quizzs] = []
        theme_level_and_children[:quizz_levels] = []
        categories_to_unlock.map{ |category_to_unlock|
          quizz_to_unlock = Quizz.find_by(category: category_to_unlock, ordering:1)
          theme_level_and_children[:quizzs] << unlock_quizz(quizz_to_unlock)
          theme_level_and_children[:quizz_levels] << unlock_quizz_level(quizz_to_unlock, "Facile")
        }
      end
      theme_level_and_children
    end
end
