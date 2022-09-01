module FlashcardsHelper
  def all_flashcards_to_learn
    current_user.flashcards.select {|flashcard|
    (flashcard.status == "learning" ||
    flashcard.status == "relearning") &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def theme_flashcards_to_learn(theme)
    current_user.flashcards.includes(:theme).includes(:question_answer).select {|flashcard|
    flashcard.theme == theme &&
    (flashcard.status == "learning" ||
    flashcard.status == "relearning") &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def all_flashcards_to_revise
    current_user.flashcards.select {|flashcard|
    flashcard.status == "learned" &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def theme_flashcards_to_revise(theme)
    current_user.flashcards.includes(:theme).select {|flashcard|
    flashcard.theme == theme &&
    flashcard.status == "learned" &&
    flashcard.day_of_next_repetition < DateTime.current}
  end

  def theme_flashcards_long_term(theme)
    current_user.flashcards.select {|flashcard|
    flashcard.theme == theme &&
    (flashcard.status == "learning" ||
    flashcard.status == "relearning") &&
    flashcard.interval > 180}
  end

  def theme_flashcards_learnt(theme)
    current_user.flashcards.select {|flashcard|
    flashcard.theme == theme &&
    flashcard.status == "learned"}
  end

  def theme_flashcards_ongoing_learning(theme)
    current_user.flashcards.select {|flashcard|
    flashcard.theme == theme &&
    (flashcard.status == "learning" ||
    flashcard.status == "relearning")}
  end

  #to display forecast to player
  # not modifying flashcard in DB
  def schedule_forecast(flashcard_true, auto_eval)
    p "auto_eval #{auto_eval}"
    flashcard = flashcard_true.dup
    p "flashcard #{flashcard}"
    if flashcard.status == 'learning'
      if auto_eval == "again"
        flashcard.steps_index = 0
        return minutes_to_days(Flashcard::NEW_STEPS[flashcard.steps_index])
      elsif auto_eval == "good"
        flashcard.steps_index += 1
        if flashcard.steps_index < Flashcard::NEW_STEPS.size
          return minutes_to_days(Flashcard::NEW_STEPS[flashcard.steps_index])
        else
          flashcard.status = 'learned'
          flashcard.interval = Flashcard::GRADUATING_INTERVAL
          return flashcard.interval
        end
      elsif auto_eval == "easy"
        flashcard.status = 'learned'
        flashcard.interval = Flashcard::EASY_INTERVAL
        return Flashcard::EASY_INTERVAL
      end
    elsif flashcard.status == 'learned'
      if auto_eval == "again"
        flashcard.status = 'relearning'
        flashcard.steps_index = 0
        flashcard.ease_factor = [130, flashcard.ease_factor - 20].max
        flashcard.interval = [Flashcard::MINIMUM_INTERVAL, flashcard.interval * Flashcard::NEW_INTERVAL/100].max
        return minutes_to_days(Flashcard::LAPSES_STEPS[0])
      elsif auto_eval == "hard"
        flashcard.ease_factor = [130, flashcard.ease_factor - 15].max
        flashcard.interval = flashcard.interval * 1.2 * Flashcard::INTERVAL_MODIFIER/100
        return [Flashcard::MAXIMUM_INTERVAL, flashcard.interval].min
      elsif auto_eval == "good"
        flashcard.interval = (flashcard.interval * flashcard.ease_factor/100 * Flashcard::INTERVAL_MODIFIER/100)
        return [Flashcard::MAXIMUM_INTERVAL, flashcard.interval].min
      elsif auto_eval == "easy"
        flashcard.ease_factor += 15
        flashcard.interval = (flashcard.interval * flashcard.ease_factor/100 * Flashcard::INTERVAL_MODIFIER/100 * Flashcard::EASY_BONUS/100)
        return [Flashcard::MAXIMUM_INTERVAL, flashcard.interval].min
      end
    elsif flashcard.status == 'relearning'
      if auto_eval == "again"
        flashcard.steps_index = 0
        return minutes_to_days(Flashcard::LAPSES_STEPS[0])
      elsif auto_eval == "good"
        flashcard.steps_index += 1
        if flashcard.steps_index < Flashcard::LAPSES_STEPS.size
          return minutes_to_days(Flashcard::LAPSES_STEPS[flashcard.steps_index])
        else
          flashcard.status = 'learned'
          return flashcard.interval
        end
      end
    end
  end


  def human_friendly_time(days)
    if days < 1
      minutes = (days * 24 * 60).round(0)
      minutes.to_s + " " + "min"
    elsif days < 30
      days.round(2).to_s + " " + "jour".pluralize(days)
    elsif days < 365
      (days / (365.25 / 12)).round(2).to_s + " " + "mois"
    else
      years = (days / 365.25).round(2)
      years.to_s + " " + " année".pluralize(years)
    end
  end
end
