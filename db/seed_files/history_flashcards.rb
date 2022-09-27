module HistoryFlashcards
  def self.seed
    game_history = Theme.new(name: "Histoire du jeu")
    game_history.image_src = '<i class="fas fa-atlas"> </i>'
    game_history.adventure_only = true
    game_history.save!

    game_history_level_1 = ThemeLevel.new(
      name: "niveau 1",
      level: 1,
      objective: " no objective!",
      theme: game_history)
    game_history_level_1.save!

    prehistory = Subtheme.new(name: "Prehistoire", theme_level: game_history_level_1)
    prehistory.save!

    timeline = Category.new(subtheme: prehistory, name: "timeline", objective: "Pas d'objectifs", ordering: 1)
    timeline.save!

    quizz = Quizz.new(category: timeline, name: "quizz", ordering: 1, crown_or_sphere:"crown")
    quizz.save!

    Level.all.each do |level|
      question_answer = QuestionAnswer.new(question: "quesstion  #{level.level} ?", answer: "answer_1", level: Level.find(level.id))
      question_answer.save!
      quizz_question_answer = QuizzQuestionAnswer.new(question_answer: question_answer, quizz: quizz)
      quizz_question_answer.save!

      question_answer = QuestionAnswer.new(question: "quesstion  #{level.level} ?", answer: "answer_1", level: Level.find(level.id))
      question_answer.save!
      quizz_question_answer = QuizzQuestionAnswer.new(question_answer: question_answer, quizz: quizz)
      quizz_question_answer.save!

      question_answer = QuestionAnswer.new(question: "quesstion  #{level.level} ?", answer: "answer_2", level: Level.find(level.id))
      question_answer.save!
      quizz_question_answer = QuizzQuestionAnswer.new(question_answer: question_answer, quizz: quizz)
      quizz_question_answer.save!

      question_answer = QuestionAnswer.new(question: "quesstion #{level.level} ?", answer: "answer_2", level: Level.find(level.id))
      question_answer.save!
      quizz_question_answer = QuizzQuestionAnswer.new(question_answer: question_answer, quizz: quizz)
      quizz_question_answer.save!

    end
  end
end
