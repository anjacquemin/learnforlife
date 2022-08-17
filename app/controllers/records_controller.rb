class RecordsController < ApplicationController

  def show
    @record = Record.find(params[:id])
    quizz_answer_id = @record.quizz_answer_id
    quizz_level = @record.quizz_level
    user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id)

    @number_of_questions = @record.question_answers.count
    @synthesis = synthesis(user_answers)

    @is_new_record = (find_best_user_record(quizz_level) == @record)
    @xp_win = xp_win_calculation(@record, @is_new_record, quizz_level)

  end

  def create
    user = current_user
    data = JSON.parse(params["json"])
    puts ("received data in method crete/records : #{data}")

    quizz_answer_id = data["quizz_answer_id"].to_i

    # BACK END CHECK NUMBER OF ANSWER = NUMBER OF QUESTION + TIME  (time_difference_in_milliseconds?)

    seconds_duration = data["final_time_seconds"]
    milliseconds_duration = data["final_time_tens"]

    quizz_level = QuizzAnswer.find(quizz_answer_id).quizz_level
    user_answers = UserAnswer.where(quizz_answer_id: quizz_answer_id)

    @record = Record.new(
      user: user,
      quizz_level: quizz_level,
      seconds_duration: seconds_duration,
      milliseconds_duration: milliseconds_duration,
      completion: completion_calculation(user_answers, seconds_duration, milliseconds_duration),
      score_percentage: score_percentage_calculation(user_answers),
      quizz_answer_id: quizz_answer_id)

    #validates number of question = number of answer

    # TO BE CHANGED : change schema add this to quizz_level
    @record.crown_or_sphere = "crown"

    @record.save!

    respond_to do |format|
      format.json
    end

  end

  private

    def synthesis(user_answers)
      @synthesis = user_answers.map do |user_answer|
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
      good_answer_count = user_answers.count{|user_answer| user_answer.answer_id == user_answer.question_answer.id}
      bad_answer_count = user_answers.count{|user_answer| user_answer.answer_id != user_answer.question_answer.id}

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

      # convert into milliseconds
      time = time_to_ms(seconds, milliseconds)
      threecrowns_autorized_time = time_to_ms(3, 0) * total_questions
      completion = 0

      if answers_count[:bad] <= one_crown_authorized_mitakes
        completion += 1
      end

      if answers_count[:bad] == 0
        completion += 1
      end

      if answers_count[:bad] == 0 && time < threecrowns_autorized_time
        completion += 1
      end

      completion
      #time
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

    # def is_new_record?(record, best_user_record)
    #   return true if record.completion > best_user_record.completion

    #   record_time = time_to_ms(record.seconds_duration, record.milliseconds_duration)
    #   best_user_record_time = time_to_ms(best_user_record.seconds_duration, best_user_record.milliseconds_duration)

    #   (record.completion == best_user_record.completion) && (record_time < best_user_record_time)
    # end

    def xp_win_calculation(record, is_new_record, quizz_level)
      # no xp if no more crowns won
      record_completion = record.completion
      return 0 if record_completion == 0 || !is_new_record

      past_best_user_record = find_past_best_user_record(quizz_level)

      # @past_best_record == nil if it is the first record
      if past_best_user_record
        past_best_record_completion = past_best_user_record.completion
        return 0 if record_completion <= past_best_record_completion

      else
        past_best_record_completion = 0
      end

      # ADD VALIDATION ON NAME OF QUIZZ LEVEL TO ENSURE THAT WE CAN FIND THE COEF
      difficulty_coefs= {Facile: 1, Moyen: 2, Difficile: 5}
      crown_coefs = [1, 2, 3]
      total_coef = 0

      total_coef = crown_coefs[past_best_record_completion, record_completion - 1].sum

      total_coef *= difficulty_coefs[record.quizz_level.name.to_sym]

    end
end
