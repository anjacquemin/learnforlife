module QuizzSeed
  def self.seed
    # SEEDS RECORDS
    anthony = User.find_by(name:"anthony")

    require "csv"

    filepath = "#{Rails.root}/db/seed_input/world_country.csv"

    world_country_capitales = []

    CSV.foreach(filepath, headers: :first_row) do |row|
      # puts "#{row['NOM']} #{row['Affectation']} #{row['CAPITALE']}"
      world_country_capitales << {
        country: row['NOM'],
        capitale: row["CAPITALE"],
        continent: row["CONTINENT"],
        subtheme: row["SUBTHEME"],
        theme: row["THEME"],
        theme_level: row["THEME_LEVEL"].to_i,
        category: row["CATEGORY"],
        quizz_ordering: row["QUIZZ_ordering"].to_i,
        image_src: row["FLAG"]
      }
    end

    # world_country_capitales.each {|c| p c}


    number_of_quizzs_per_subtheme = {
      Europe: 4,
      "Iles des Caraibes": 2,
      "Iles Pacifiques": 2,
      Asie: 4,
      Amérique: 2,
      Afrique:5,
      Master: 1
    }



    quizzs = []

    Category.all.each do |category|
      category_progress = CategoryProgress.new(user: anthony, category: category, unlocked: false)
      category_progress.save!
      nb_quizz = number_of_quizzs_per_subtheme[category.subtheme.name.to_s.to_sym]
      # for world categ
      nb_quizz = (nb_quizz ? nb_quizz : 1)
      if nb_quizz != 1
        (1..nb_quizz).each do |i|
          quizz = Quizz.new(category: category, name: "QUIZZ #{i}", ordering: i, crown_or_sphere: "crown")
          quizz.save!
          quizzs << quizz
        end
        quizz = Quizz.new(category: category, name: "MASTER", ordering: nb_quizz + 1, crown_or_sphere: "crown")
        quizz.save!
        quizzs << quizz
      else
        quizz = Quizz.new(category: category, name: "MASTER", ordering: nb_quizz, crown_or_sphere: "sphere")
        quizz.save!
        quizzs << quizz
      end
    end

    # p "quizz level"

    #localization quizz
    quizz_levels = []
    quizzs.each do |quizz|
      unlocked = (quizz.ordering == 1 && quizz.theme_level.level == 1)
      quizz_progress = QuizzProgress.new(user: anthony, quizz: quizz, unlocked: unlocked)
      quizz_progress.save!

      ["Facile", "Moyen", "Difficile"].each do |level|
        crown_or_sphere = "crown"
        if quizz.category.subtheme == quizz.theme.subthemes.last
          crown_or_sphere = "sphere"
        end
        quizz_level = QuizzLevel.new(name: level, quizz: quizz, crown_or_sphere: crown_or_sphere)
        quizz_level.save!
        quizz_levels << quizz_level
      end
    end

    # p "quizz level"

    quizz_levels.each do |quizz_level|
      unlocked = (quizz_level.quizz.ordering == 1 && quizz_level.quizz.theme_level.level == 1 && quizz_level.name == "Facile")
      quizz_level_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level, unlocked: unlocked)
      quizz_level_progress.save!
    end

    #questions / answers

    geo_subthemes = Theme.find_by(name: "Geographie").subthemes

    Subtheme.all.each do |subtheme|
      subtheme.quizzs.each do |quizz|
        world_country_capitales.each do |csv_capitale|
          if (quizz.category.subtheme.name == csv_capitale[:subtheme] &&
              quizz.theme_level.level.to_i == csv_capitale[:theme_level].to_i && quizz.ordering == csv_capitale[:quizz_ordering].to_i)
            if quizz.category.name == "Capitales" || quizz.category.name == "Drapeaux" || quizz.category.name == "Localisation"
              if quizz.category.name == "Capitales"
                question = "Quelle est la capitale de ce pays : #{csv_capitale[:country].capitalize} ?"
                answer = csv_capitale[:capitale]
                image_src = nil
              elsif quizz.category.name == "Drapeaux"
                # p "drapeau"
                question = "Quel est ce pays ?"
                answer = csv_capitale[:country]
                # p answer
                image_src = csv_capitale[:image_src] + ".png"
              elsif quizz.category.name == "Localisation"
                # p "localisation"
                question = "Quel est ce pays ?"
                answer = csv_capitale[:country]
                # p answer
                image_src = csv_capitale[:image_src] + ".PNG"
              end
              answer = csv_capitale[:capitale] if !answer
              question_answer = QuestionAnswer.new(question: question, answer: answer, image_src: image_src)
              question_answer.save!

              quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz, question_answer: question_answer)
              quizz_question_answers.save!

              quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz.category.quizzs.find_by(name: "MASTER"), question_answer: question_answer)
              quizz_question_answers.save!

              quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz.theme.subthemes.last.categories.find_by(name: quizz.category.name).quizzs.find_by(name: "MASTER"), question_answer: question_answer)
              quizz_question_answers.save!
            end
          end
        end
      end
    end
  end
end
