class FlashcardsController < ApplicationController

  def index
    policy_scope(Flashcard)
    @theme = Theme.find(params[:theme_id])

    if (@learn_or_revise = params[:learn_or_revise]) == "learn"
      @flashcards = current_user.flashcards.includes([:question_answer]).includes([:theme]).select {|flashcard|
        flashcard.theme == @theme &&
        (flashcard.status == "learning" || flashcard.status == "relearning") &&
        flashcard.day_of_next_repetition < DateTime.current
    }.first(10)
    else
      @flashcards = current_user.flashcards.select {|flashcard|
        flashcard.theme == @theme &&
        flashcard.status == "learned" &&
        flashcard.day_of_next_repetition < DateTime.current
    }.first(10)
    end
  end

  def update
    data = JSON.parse(params["json"])

    @flashcard = Flashcard.find(data["flashcard_id"])
    puts @flashcard.user.name
    authorize(@flashcard)

    auto_eval = data["auto_eval"]
    @number_of_card_to_display = data["number_of_card_to_display"]
    # clasculer
    interval = schedule(@flashcard, auto_eval)


    puts "next repittion : #{@flashcard.day_of_next_repetition}"
    puts "interval : #{interval}"
    puts "status : #{@flashcard.status}"
    puts "ease factor : #{@flashcard.ease_factor}"
    puts "steps index : #{@flashcard.steps_index}"

    # compute la due date
    #

    # only show again in current deck if 1 minute
    # Means calculated interval is < 1 day
    if interval < 1
      @minutes = days_to_minutes(interval)
      puts "interval :#{@minutes}"
      @flashcard.day_of_next_repetition = DateTime.current + @minutes.minutes
      @flashcard.save!
      puts "next repetition : :#{@flashcard.day_of_next_repetition}"
    else
      @flashcard.day_of_next_repetition = DateTime.current + interval.day
      @flashcard.save!
    end

    flashcard_save = FlashcardSave.new({
      interval: @flashcard.interval,
      repetition: @flashcard.repetition,
      ease_factor: @flashcard.ease_factor,
      auto_eval: auto_eval,
      day_of_repetition: DateTime.current,
      flashcard: @flashcard,
      status: @flashcard.status,
      steps_index: @flashcard.steps_index
      })
    flashcard_save.save!

    respond_to do |format|
      # format.html
      format.json
    end


    # if not toaday ok

    #if not put in the deck
  end

  def results
    @theme = Theme.find(params[:theme_id])
    @flashcards = current_user.flashcards.includes([:question_answer]).includes([:theme]).includes([:flashcard_saves]).select {|flashcard| flashcard.theme == @theme}
    authorize (@flashcards.first)
    @flashcard_dealt_with = current_user.flashcard_saves.select{ |flashcard_save| !flashcard_save.dealt_with }
    @flashcard_dealt_with_count = @flashcard_dealt_with.pluck(:flashcard_id).uniq.count

    @gold_win = 0
    count = 0

    @flashcard_dealt_with.each do |flashcard_save|
      unless flashcard_save.dealt_with
        flashcard_save.dealt_with = true
        flashcard_save.save!
        count += 1
        @gold_win += 1
      end
    end

    @gold_win = (count < @flashcard_dealt_with_count ? count : @gold_win)

    current_user.gold += @gold_win
    current_user.save!

  end
end


  private

    def schedule(flashcard, auto_eval)
      '''auto_eval is one of "again", "hard", "good", or "easy"
      returns a result in days'''

      p "autoeval : #{auto_eval}"
      flashcard.repetition += 1

      if flashcard.status == 'learning'
        p "learning"
        # for learning flashcards, there is no "hard" auto_eval possible
        if auto_eval == "again"
          flashcard.steps_index = 0
          p "again"
          flashcard.save!
          return minutes_to_days(Flashcard::NEW_STEPS[flashcard.steps_index])
        elsif auto_eval == "good"
          p "good"
          flashcard.steps_index += 1
          if flashcard.steps_index < Flashcard::NEW_STEPS.size
            flashcard.save!
            p "minutes to dayx : #{minutes_to_days(Flashcard::NEW_STEPS[flashcard.steps_index])}"
            return minutes_to_days(Flashcard::NEW_STEPS[flashcard.steps_index])
          else
            # we have graduated!
            flashcard.status = 'learned'
            flashcard.interval = Flashcard::GRADUATING_INTERVAL
            flashcard.save!
            return flashcard.interval
          end
        elsif auto_eval == "easy"
          flashcard.status = 'learned'
          flashcard.interval = Flashcard::EASY_INTERVAL
          flashcard.save!
          return Flashcard::EASY_INTERVAL
        end
      elsif flashcard.status == 'learned'
        if auto_eval == "again"
          flashcard.status = 'relearning'
          flashcard.steps_index = 0
          flashcard.ease_factor = [130, flashcard.ease_factor - 20].max
          flashcard.interval = [Flashcard::MINIMUM_INTERVAL, flashcard.interval * Flashcard::NEW_INTERVAL/100].max
          flashcard.save!
          return minutes_to_days(Flashcard::LAPSES_STEPS[0])
        elsif auto_eval == "hard"
          flashcard.ease_factor = [130, flashcard.ease_factor - 15].max
          flashcard.interval = flashcard.interval * 1.2 * Flashcard::INTERVAL_MODIFIER/100
          flashcard.save!
          return [Flashcard::MAXIMUM_INTERVAL, flashcard.interval].min
        elsif auto_eval == "good"
          flashcard.interval = (flashcard.interval * flashcard.ease_factor/100 * Flashcard::INTERVAL_MODIFIER/100)
          flashcard.save!
          return [Flashcard::MAXIMUM_INTERVAL, flashcard.interval].min
        elsif auto_eval == "easy"
          flashcard.ease_factor += 15
          flashcard.interval = (flashcard.interval * flashcard.ease_factor/100 * Flashcard::INTERVAL_MODIFIER/100 * Flashcard::EASY_BONUS/100)
          flashcard.save!
          return [Flashcard::MAXIMUM_INTERVAL, flashcard.interval].min
        end
      elsif flashcard.status == 'relearning'
        if auto_eval == "again"
          flashcard.steps_index = 0
          flashcard.save!
          return minutes_to_days(Flashcard::LAPSES_STEPS[0])
        elsif auto_eval == "good"
          flashcard.steps_index += 1
          if flashcard.steps_index < Flashcard::LAPSES_STEPS.size
            flashcard.save!
            return minutes_to_days(Flashcard::LAPSES_STEPS[flashcard.steps_index])
          else
            # we have re-graduated!
            flashcard.status = 'learned'
            # we don't modify the interval here because that was already done when
            # going from 'learned' to 'relearning'
            flashcard.save!
            return flashcard.interval
          end
        end
      end
    end

    def minutes_to_days(minutes)
      minutes.to_f / (60 * 24)
    end

    def days_to_minutes(day)
      (day.to_f * 60 * 24).round
    end
