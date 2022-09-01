# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

_IMAGE_DIR_ = "./app/assets/images/"


puts 'seed'

FlashcardSave.destroy_all
BestRecord.destroy_all
QuizzLevelProgress.destroy_all
UserAnswer.destroy_all
Record.destroy_all
QuizzAnswer.destroy_all
User.destroy_all
Level.destroy_all
QuizzQuestionAnswer.destroy_all
QuestionAnswer.destroy_all
QuizzLevel.destroy_all
Quizz.destroy_all
Category.destroy_all
Subtheme.destroy_all
ThemeLevel.destroy_all
Theme.destroy_all


######LELVEL#####

level1 = Level.new(level: 1,
                    required_xp: 20,
                    beginning_year:-1000000,
                    period:"Préhistoire",
                    sub_period: "Paléolithique ancien",
                    social_type: "Homo habilis")
level1.save!

level2 = Level.new(level: 2,
                    required_xp: 25,
                    beginning_year:-200000,
                    period:"Préhistoire",
                    sub_period: "Paléolithique moyen",
                    social_type: "Homo Néendertal")
level2.save!
level3 = Level.new(level: 3,
                    required_xp: 30,
                    beginning_year:-35000,
                    period:"Préhistoire",
                    sub_period: "Paléolithique supérieur",
                    social_type: "Homo sapiens")
level3.save!
level4 = Level.new(level: 4,
                    required_xp: 35,
                    beginning_year:-10000,
                    period:"Préhistoire",
                    sub_period: "Mésolithique ancien",
                    social_type: "Meso 1")
level4.save!
level5 = Level.new(level: 5,
                    required_xp: 40,
                    beginning_year:-8000,
                    period:"Préhistoire",
                    sub_period: "Mésolithique moyen",
                    social_type: "Meso 2")
level5.save!
level6 = Level.new(level: 6,
                    required_xp: 40,
                    beginning_year:-7000,
                    period:"Préhistoire",
                    sub_period: "Mésolithique récent",
                    social_type: "Meso 3")
level6.save!
level7 = Level.new(level: 7,
                    required_xp: 40,
                    beginning_year:-6000,
                    period:"Préhistoire",
                    sub_period: "Neolithique supérieur",
                    social_type: "neo 1")
level7.save!
level8 = Level.new(level: 8,
                    required_xp: 40,
                    beginning_year:-4500,
                    period:"Préhistoire",
                    sub_period: "Mésolithique supérieur",
                    social_type: "neo 2")
level8.save!
level9 = Level.new(level: 9,
                    required_xp: 40,
                    beginning_year:-3500,
                    period:"Préhistoire",
                    sub_period: "Néolithique supérieur",
                    social_type: "neo 3")
level9.save!


(10..40).each { |level|
  level9 = Level.new(level: level,
                    required_xp: 30,
                    beginning_year:-3500,
                    period:"period #{level}",
                    sub_period: "sub period #{level}",
                    social_type: "social type #{level}")
  level9.save!
}

######USER#####

anthony = User.new(
    name: "anthony",
    email: "anthony@gmail.gmail",
    password: "foobar",
    password_confirmation: "foobar",
    hp: 45,
    hp_max: 50,
    xp: 0,
    gem: 12,
    gold: 1100,
    level: level1
)
anthony.save!



##########################

geography = Theme.new(name: "Geographie")
geography.photo.attach(io: File.open(_IMAGE_DIR_ + 'globe.png'), filename:"globe.png")
geography.save!

history = Theme.new(name: "Histoire")
history.photo.attach(io: File.open(_IMAGE_DIR_ + 'livre-dhistoire.png'), filename:"histoire.png")
history.save!

mnemotechnique = Theme.new(name: "Mnemotechnie")
mnemotechnique.photo.attach(io: File.open(_IMAGE_DIR_ + 'creatif.png'), filename:"creatif.png")
mnemotechnique.save!

sports = Theme.new(name: "Sports")
sports.photo.attach(io: File.open(_IMAGE_DIR_ + 'des-sports.png'), filename:"sports.png")
sports.save!

# Geography levels

geography_level_1 = ThemeLevel.new(
    name: "niveau 1",
    level: 1,
    objective: "Débloque les badges Capitales, Localisation et Drapeau pour accéder au NIVEAU 2 geography !",
    theme: geography)
geography_level_1.save!

geography_level_2 = ThemeLevel.new(
    name: "Niveau 2",
    level: 2,
    objective: "Débloque les badges Capitales, Localisation et Drapeau pour accéder au NIVEAU 3 Europe !",
    theme: geography)
geography_level_2.save!


geography_level_3 = ThemeLevel.new(
    name: "Niveau 3",
    level: 3,
    objective: "Débloque les badges Capitales, Localisation et Drapeau pour débloquer des sphères de connaissances !",
    theme: geography)
geography_level_3.save!



# Geography subtheme
subthemes = []
europe = Subtheme.new(name: "Europe", theme_level: geography_level_1)
europe.save!
subthemes << europe


america = Subtheme.new(name: "Amérique", theme_level: geography_level_1)
america.save!
subthemes << america

africa = Subtheme.new(name: "Afrique", theme_level: geography_level_1)
africa.save!
subthemes << africa

asia = Subtheme.new(name: "Asie", theme_level: geography_level_1)
asia.save!
subthemes << asia

# oceania = Subtheme.new(name: "Océanie", theme_level: geography_level_1)
# oceania.save!
# subthemes << oceania

caraibeean = Subtheme.new(name: "Iles des Caraibes", theme_level: geography_level_2)
caraibeean.save!
subthemes << caraibeean

pacifica = Subtheme.new(name: "Iles Pacifiques", theme_level: geography_level_2)
pacifica.save!
subthemes << pacifica

world = Subtheme.new(name: "Mondes", theme_level: geography_level_3)
world.save!
subthemes << world


#Level progress geography for anthony
anthony_geography_level_1_progress = ThemeLevelProgress.new(user: anthony, theme_level: geography_level_1, unlocked: true)
anthony_geography_level_1_progress.save!

anthony_geography_level_2_progress = ThemeLevelProgress.new(user: anthony, theme_level: geography_level_2, unlocked: false)
anthony_geography_level_2_progress.save!

anthony_geography_level_3_progress = ThemeLevelProgress.new(user: anthony, theme_level: geography_level_3, unlocked: false)
anthony_geography_level_3_progress.save!


#Subtheme progression for anthony, level 1 geography
subtheme_progress = []
anthony_europe_progress = SubthemeProgress.new(user: anthony, subtheme: europe, unlocked: true)
anthony_europe_progress.save!


anthony_africa_progress = SubthemeProgress.new(user: anthony, subtheme: africa, unlocked: true)
anthony_africa_progress.save!

anthony_america_progress = SubthemeProgress.new(user: anthony, subtheme: america, unlocked: true)
anthony_america_progress.save!

# anthony_oceania_progress = SubthemeProgress.new(user: anthony, subtheme: oceania, unlocked: true)
# anthony_oceania_progress.save!

anthony_asia_progress = SubthemeProgress.new(user: anthony, subtheme: asia, unlocked: true)
anthony_asia_progress.save!

anthony_caraibeean_progress = SubthemeProgress.new(user: anthony, subtheme: caraibeean, unlocked: false)
anthony_caraibeean_progress.save!

anthony_pacifica_progress = SubthemeProgress.new(user: anthony, subtheme: pacifica, unlocked: false)
anthony_pacifica_progress.save!

anthony_world_progress = SubthemeProgress.new(user: anthony, subtheme: world, unlocked: false)
anthony_world_progress.save!


#categories

categories = []

subthemes.each do |subtheme|
  capitale = Category.new(subtheme: subtheme, name: "Capitales", objective: "Obtiens 2 couronnes au quizz 'Capitale #{subtheme.name} Master' niveau moyen pour obtenir le badge capitale")
  capitale.photo.attach(io: File.open(_IMAGE_DIR_ + 'tour-eiffel.png'), filename:"capitale.png")
  capitale.save!
  categories << capitale

  localization = Category.new(subtheme: subtheme, name: "Localisation", objective: "Obtiens 2 couronnes au quizz 'Localisation #{subtheme.name} Master' niveau moyen pour obtenir le badge localisation")
  localization.photo.attach(io: File.open(_IMAGE_DIR_ + 'map.png'), filename:"map.png")
  localization.save!
  categories << localization

  flag = Category.new(subtheme: subtheme, name: "Drapeaux", objective: "Obtiens 2 couronnes au quizz 'Drapeaux #{subtheme.name} Master' niveau moyen pour obtenir le badge drapeau")
  flag.photo.attach(io: File.open(_IMAGE_DIR_ + 'flag.png'), filename:"flag.png")
  flag.save!
  categories << flag
end





# quizz_capitale_europe_1_QA_3 = QuestionAnswer.new(question: "quelle est la capitale de l'Allemagne ?", answer: "Berlin", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_3.save!

# quizz_capitale_europe_1_QA_4 = QuestionAnswer.new(question: "quelle est la capitale de l'Espagne' ?", answer: "Madrid", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_4.save!

# quizz_capitale_europe_1_QA_5 = QuestionAnswer.new(question: "quelle est la capitale du Royaume unis?", answer: "Londres", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_5.save!

# quizz_capitale_europe_1_QA_6 = QuestionAnswer.new(question: "quelle est la capitale du Portugal ?", answer: "Lisbonne", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_6.save!

# quizz_capitale_europe_1_QA_7 = QuestionAnswer.new(question: "quelle est la capitale de l'Italie' ?", answer: "Rome", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_7.save!


# quizz_capitale_europe_1_QA_8 = QuestionAnswer.new(question: "quelle est la capitale de la Suède' ?", answer: "Stockolm", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_8.save!


# quizz_capitale_europe_1_QA_9 = QuestionAnswer.new(question: "quelle est la capitale des pys bas ?", answer: "Amsterdam", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_9.save!

# quizz_capitale_europe_1_QA_10 = QuestionAnswer.new(question: "quelle est la capitale de la Suisse' ?", answer: "Berne", quizz: quizz_capitale_europe_1)
# quizz_capitale_europe_1_QA_10.save!

# Pour quizz faire par ordre de populalation pour créer les paquets


# #Flashcards for anthony

# flashcard_1 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_1)
# flashcard_1.save!

# flashcard_2 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_2)
# flashcard_2.save!

# flashcard_3 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_3)
# flashcard_3.save!

# flashcard_4 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_4)
# flashcard_4.save!


#achievements

achievement_1 = Achievement.new(name: "Roi de la connexion", description: "5 jours de connexion de suite", xp_to_win: 17)
achievement_1.save!

achievement_2 = Achievement.new(name: "Boss de la connexion", description: "10 jours de connexion de suite", xp_to_win: 52)
achievement_2.save!

#anthony's achievements

anthony_achievemnt_1 = UserAchievement.new(achievement: achievement_1, unlocked:true, user: anthony)
anthony_achievemnt_1.save!

anthony_achievemnt_2 = UserAchievement.new(achievement: achievement_2, unlocked:false, user: anthony)
anthony_achievemnt_2.save!





# SEEDS RECORDS

# quizz_level = QuizzLevel.first

# (0..10).each do |n|
#   user = User.new(
#     name: "user#{n}",
#     email: "user#{n}@gmail.gmail",
#     password: "foobar",
#     password_confirmation: "foobar",
#     hp: 45 + n,
#     xp: 37+ n,
#     hp_max: 50,
#     gem: 12+ n,
#     gold: 1100+ n,
#     level: level1
#   )
#   user.save!
#   record = Record.new(user: user, quizz_level: quizz_level, seconds_duration: 1000- (n * 10), milliseconds_duration: 1, crown_or_sphere: "crown", completion: 1)
#   record.save!

#   record = Record.new(user: user, quizz_level: quizz_level, seconds_duration: 1000- (n * 10), milliseconds_duration: 1,crown_or_sphere: "crown", completion: 2)
#   record.save!

#   best_record = BestRecord.new(record: record, quizz_level: quizz_level, theme: quizz_level.theme)
#   best_record.save!
# end

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

categories.each do |category|
    category_progress = CategoryProgress.new(user: anthony, category: category, unlocked: false)
    category_progress.save!

    p "category : #{category}"

    p "category subtheme #{category.subtheme}"
    p "category subtheme #{category.subtheme.name}"

    p number_of_quizzs_per_subtheme[category.subtheme.name.to_s.to_sym]

    nb_quizz = number_of_quizzs_per_subtheme[category.subtheme.name.to_s.to_sym]

    # for world categ
    nb_quizz = (nb_quizz ? nb_quizz : 1)

    if nb_quizz != 1
      (1..nb_quizz).each do |i|
        quizz = Quizz.new(category: category, name: "QUIZZ #{i}", ordering: i)
        p quizz.name
        quizz.save!
        quizzs << quizz
      end
      quizz = Quizz.new(category: category, name: "MASTER", ordering: nb_quizz + 1)
      quizz.save!
      quizzs << quizz
    else
      quizz = Quizz.new(category: category, name: "MASTER", ordering: nb_quizz)
      quizz.save!
      quizzs << quizz
    end
end

p "quizz level"

#localization quizz
quizz_levels = []
quizzs.each do |quizz|
  unlocked = (quizz.ordering == 1 && quizz.theme_level.level == 1)
  quizz_progress = QuizzProgress.new(user: anthony, quizz: quizz, unlocked: unlocked)
  quizz_progress.save!

  ["Facile", "Moyen", "Difficile"].each do |level|
    quizz_level = QuizzLevel.new(name: level, quizz: quizz)
    quizz_level.save!
    quizz_levels << quizz_level
  end
end

p "quizz level"

quizz_levels.each do |quizz_level|
  unlocked = (quizz_level.quizz.ordering == 1 && quizz_level.quizz.theme_level.level == 1 && quizz_level.name == "Facile")
  quizz_level_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level, unlocked: unlocked)
  quizz_level_progress.save!
end

#questions / answers

geo_subthemes = Theme.find_by(name: "Geographie").subthemes

subthemes.each do |subtheme|
  subtheme.quizzs.each do |quizz|
    p quizz.name

    world_country_capitales.each do |csv_capitale|
      # if quizz.category.subtheme.name == "Mondes" && quizz.category.name == "Capitales"
      #   if csv_capitale[:capitale]
      #     question_answer = QuestionAnswer.new(question: "quelle est la capitale de la #{csv_capitale[:country]} ?", answer: csv_capitale[:capitale])
      #     question_answer.save!
      #     quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz, question_answer: question_answer)
      #     quizz_question_answers.save!
      #   else
      #     p "pas de capitale pour #{csv_capitale[:country]}  "
      #   end
      # else

        # if quizz.category.name == "Capitales" && quizz.category.subtheme.name == "Europe" && quizz.ordering == 1

        #   p csv_capitale
        #   p quizz.category.subtheme.name
        #   p csv_capitale[:subtheme]
        #   p quizz.theme_level.level.to_i
        #   p csv_capitale[:theme_level].to_i
        #   p quizz.category.name
        #   p csv_capitale[:category]
        #   p quizz.ordering
        #   p csv_capitale[:quizz_ordering].to_i
        # end

        if (quizz.category.subtheme.name == csv_capitale[:subtheme] &&
            quizz.theme_level.level.to_i == csv_capitale[:theme_level].to_i && quizz.category.name == csv_capitale[:category] &&
            quizz.ordering == csv_capitale[:quizz_ordering].to_i)

          question_answer = QuestionAnswer.new(question: "quelle est la capitale de la #{csv_capitale[:country]} ?", answer: csv_capitale[:capitale])
          question_answer.save!

          quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz, question_answer: question_answer)
          quizz_question_answers.save!

          quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz.category.quizzs.find_by(name: "MASTER"), question_answer: question_answer)
          quizz_question_answers.save!

          quizz_question_answers = QuizzQuestionAnswer.new(quizz: quizz.theme.subthemes.last.categories.find_by(name: quizz.category.name).quizzs.find_by(name: "MASTER"), question_answer: question_answer)
          quizz_question_answers.save!
        end
      # end
    end
  end
end

# SPECIAL INFO FOR ANTHONY USER

# ThemeLevel.find_by(level: 1).category_progresses.where(user: anthony).each { |category_progress|
# category_progress.unlocked = true
# category_progress.save!
# }

# ThemeLevel.find_by(level: 1).quizz_progresses.where(user: anthony).each { |quizz_progress|
# quizz_progress.unlocked = true
# quizz_progress.save!
# }

# anthony = User.first
# ThemeLevel.find_by(level: 1).quizz_level_progresses.where(user: anthony).each { |quizz_level_progress|
#   quizz_level_progress.unlocked = true
#   quizz_level_progress.save!
# }


# Subtheme.find_by(name: "Océanie").category_progresses.where(user: anthony).each { |category_progress|
#   category_progress.unlocked = false
#   category_progress.save!
# }

# Subtheme.find_by(name: "Océanie").quizz_progresses.where(user: anthony).each { |quizz_progress|
#   unlocked = (quizz_progress.quizz.ordering == 1 && quizz_progress.quizz.theme_level.level == 1 || quizz_progress.quizz.name == "Capitale Océanie Master")
#   quizz_progress.unlocked = unlocked
#   quizz_progress.save!
# }

# anthony = User.first
# Subtheme.find_by(name: "Océanie").quizz_level_progresses.where(user: anthony).each { |quizz_level_progress|
#   unlocked = (quizz_level_progress.quizz_level.quizz.ordering == 1 && quizz_level_progress.quizz_level.quizz.theme_level.level == 1 &&quizz_level_progress.quizz_level.name == "Facile" || quizz_level_progress.quizz_level.quizz.name == "Océanie Master")
#   quizz_level_progress.unlocked = unlocked
#   quizz_level_progress.save!
# }
