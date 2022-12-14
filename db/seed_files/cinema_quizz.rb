
module CinemaQuizzSeed
  def self.seed
    require "csv"



    anthony = User.first

    filepath = "#{Rails.root}/db/seed_input/cinema.csv"

    cinema_questions = []
    CSV.foreach(filepath, headers: :first_row) do |row|
      # puts "#{row['NOM']} #{row['Affectation']} #{row['CAPITALE']}"
      cinema_questions << {
        question: row['Question'],
        good_answer: row["Good_answer"],
        suggested_answer_1: row["Suggested_answer_1"],
        suggested_answer_2: row["Suggested_answer_2"],
        suggested_answer_3: row["Suggested_answer_3"],
        theme_level: row["Level"].to_i,
        subtheme: row["Subthemes"],
        category: row["Category"],
        quizz_ordering: row["Quizz_ordering"].to_i
      }
    end
    p "cine_question #{cinema_questions[0]}"

    subthemes = {}

    category_img = {
      "Oscar meilleur film".to_sym => "academy-award.png",
      "culture générale".to_sym => "movie-start.png",
      "Année".to_sym => "clapperboard.png",
      "Acteur".to_sym => "actor.png",
      "Producteur".to_sym => "gopro.png"
    }


    cinema_questions.each do |cinema_question|
      subtheme = cinema_question[:subtheme].to_sym
      category = cinema_question[:category].to_sym
      quizz_ordering = cinema_question[:quizz_ordering].to_s.to_sym
      question = cinema_question[:question].to_sym
      subthemes[subtheme] = {} if !subthemes[subtheme]
      subthemes[subtheme][category] = {} if !subthemes[subtheme][category]
      subthemes[subtheme][category][quizz_ordering] = {} if !subthemes[subtheme][category][quizz_ordering]
      subthemes[subtheme][category][quizz_ordering][question] = {} if !subthemes[subtheme][category][quizz_ordering][question]
      subthemes[subtheme][category][quizz_ordering][question][:good_answer] = cinema_question[:good_answer]
      subthemes[subtheme][category][quizz_ordering][question][:suggested_answer_1] = cinema_question[:suggested_answer_1]
      subthemes[subtheme][category][quizz_ordering][question][:suggested_answer_2] = cinema_question[:suggested_answer_2]
      subthemes[subtheme][category][quizz_ordering][question][:suggested_answer_3] = cinema_question[:suggested_answer_3]
    end



    subthemes.each do |subtheme, category|
      category_ordering = 1
      p subtheme
      p category.keys
      category.each do |category, quizz_ordering|
        p subtheme.to_s
        category_record = Category.new(subtheme: Subtheme.find_by(name: subtheme.to_s), name: category, objective: "Obtiens <strong>2 couronnes</strong> au quizz <strong>Master</strong> niveau <strong>moyen</strong> pour obtenir le <strong>badge capitale</strong>", ordering: category_ordering, img_src: category_img[category.to_sym])
        category_record.save!

        category_progress = CategoryProgress.new(user: anthony, category: category_record, unlocked: false)
        category_progress.save!

        category_ordering += 1
        number_of_quizzs = quizz_ordering.keys.count
        quizzs_count = 1

        if number_of_quizzs != 1
          quizz = Quizz.new(category: category_record, name: "MASTER", ordering: number_of_quizzs + 1, crown_or_sphere: "crown")
          quizz.save!
          ["Facile", "Moyen", "Difficile"].each do |level|
            crown_or_sphere = (quizz.category.subtheme.theme_level == quizz.theme.theme_levels.last) ? "sphere" : "crown"
            quizz_level = QuizzLevel.new(name: level, quizz: quizz, crown_or_sphere: crown_or_sphere)
            quizz_level.save!

            unlocked = (quizz_level.quizz.ordering == 1 && quizz_level.quizz.theme_level.level == 1 && quizz_level.name == "Facile")
            quizz_level_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level, unlocked: unlocked)
            quizz_level_progress.save!
          end
        end

        quizz_ordering.each do |quizz_ordering, question|
          quizz_name = (number_of_quizzs == 1) ? "MASTER" : "QUIZZ #{quizz_ordering}"
          p "Quizz ordering : #{quizz_ordering}"
          quizz = Quizz.new(category: category_record, name: quizz_name, ordering: quizz_ordering.to_s.to_i, crown_or_sphere: "crown")
          quizz.save!
          quizzs_count += 1

          unlocked = (quizz.ordering == 1 && quizz.theme_level.level == 1)
          quizz_progress = QuizzProgress.new(user: anthony, quizz: quizz, unlocked: unlocked)
          quizz_progress.save!

          ["Facile", "Moyen", "Difficile"].each do |level|
            crown_or_sphere = (quizz.category.subtheme.theme_level == quizz.theme.theme_levels.last) ? "sphere" : "crown"
            quizz_level = QuizzLevel.new(name: level, quizz: quizz, crown_or_sphere: crown_or_sphere)
            quizz_level.save!

            unlocked = (quizz_level.quizz.ordering == 1 && quizz_level.quizz.theme_level.level == 1 && quizz_level.name == "Facile")
            quizz_level_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level, unlocked: unlocked)
            quizz_level_progress.save!
          end

          # p question.keys
          question.each do |question, answer_type|
            question_answer = QuestionAnswer.new(question: question, answer: answer_type[:good_answer])
            question_answer.save!

            quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz, question_answer: question_answer)
            quizz_question_answers.save!

            quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz.category.quizzs.find_by(name: "MASTER"), question_answer: question_answer)
            quizz_question_answers.save!

            quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz.theme.theme_levels.last.categories.find_by(name: quizz.category.name).quizzs.find_by(name: "MASTER"), question_answer: question_answer)
            quizz_question_answers.save!

            answer_type.each do |answer_type, answer|
              quizz_question_answers = SuggestedAnswer.new(answer: answer, question_answer: question_answer)
              quizz_question_answers.save!
            end
          end
        end
      end
    end
  end
end
