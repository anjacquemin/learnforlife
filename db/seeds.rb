# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Record.destroy_all
User.destroy_all
QuestionAnswer.destroy_all
QuizzLevel.destroy_all
Quizz.destroy_all
Category.destroy_all
Subtheme.destroy_all
ThemeLevel.destroy_all
Theme.destroy_all

geography = Theme.new(name: "geography")
geography.save!

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
europe = Subtheme.new(name: "Europe", theme_level: geography_level_1)
europe.save!

america = Subtheme.new(name: "Amérique", theme_level: geography_level_1)
america.save!

africa = Subtheme.new(name: "Afrique", theme_level: geography_level_1)
africa.save!

asia = Subtheme.new(name: "Asie", theme_level: geography_level_1)
asia.save!

oceania = Subtheme.new(name: "Océanie", theme_level: geography_level_1)
oceania.save!

caraibeean = Subtheme.new(name: "Iles des Caraibes", theme_level: geography_level_2)
caraibeean.save!

pacifica = Subtheme.new(name: "Iles Pacifiques", theme_level: geography_level_2)
pacifica.save!

world = Subtheme.new(name: "Mondes", theme_level: geography_level_3)
world.save!


#categories

capitale = Category.new(subtheme: europe, name: "Capitales", objective: "Obtiens 2 couronnes au quizz 'Capitale Europe Master' niveau moyen pour obtenir le badge capitale")
capitale.save!

localization = Category.new(subtheme: europe, name: "Localisation", objective: "Obtiens 2 couronnes au quizz 'Localisation Europe Master' niveau moyen pour obtenir le badge localisation")
localization.save!

flag = Category.new(subtheme: europe, name: "Capitales", objective: "Obtiens 2 couronnes au quizz 'Drapeaux Europe Master' niveau moyen pour obtenir le badge drapeau")

flag.save!

#capitales quizz

quizz_capitale_europe_1 = Quizz.new(category: capitale, name: "Capitale Europe #1", ordering: 1)
quizz_capitale_europe_1.save!

quizz_capitale_europe_2 = Quizz.new(category: capitale, name: "Capitale Europe #2", ordering: 2)
quizz_capitale_europe_2.save!

quizz_capitale_europe_3 = Quizz.new(category: capitale, name: "Capitale Europe #3", ordering: 3)
quizz_capitale_europe_3.save!

quizz_capitale_europe_4 = Quizz.new(category: capitale, name: "Capitale Europe Master", ordering: 4)
quizz_capitale_europe_4.save!


#localization quizz

quizz_localization_europe_1 = Quizz.new(category: localization, name: "Localisation Europe #1", ordering: 1)
quizz_localization_europe_1.save!

quizz_localization_europe_2 = Quizz.new(category: localization, name: "Localisation Europe #2", ordering: 2)
quizz_localization_europe_2.save!

quizz_localization_europe_3 = Quizz.new(category: localization, name: "Localisation Europe #3", ordering: 3)
quizz_localization_europe_3.save!

quizz_localization_europe_4 = Quizz.new(category: localization, name: "Localisation Europe Master", ordering: 4)
quizz_localization_europe_4.save!


#flag quizz
quizz_flag_europe_1 = Quizz.new(category: flag, name: "Drapeaux Europe #1", ordering: 1)
quizz_flag_europe_1.save!

quizz_flag_europe_2 = Quizz.new(category: flag, name: "Drapeaux Europe #2", ordering: 2)
quizz_flag_europe_2.save!

quizz_flag_europe_3 = Quizz.new(category: flag, name: "Drapeaux Europe #3", ordering: 3)
quizz_flag_europe_3.save!

quizz_flag_europe_4 = Quizz.new(category: flag, name: "Drapeaux Europe Master", ordering: 4)
quizz_flag_europe_4.save!


#quizz level
quizz_level_easy_capitale_europe_1 = QuizzLevel.new(name: "Facile", quizz: quizz_capitale_europe_1)
quizz_level_easy_capitale_europe_1.save!

quizz_level_medium_capitale_europe_1 = QuizzLevel.new(name: "Moyen", quizz: quizz_capitale_europe_1)
quizz_level_medium_capitale_europe_1.save!

quizz_level_hard_capitale_europe_1 = QuizzLevel.new(name: "Difficile", quizz: quizz_capitale_europe_1)
quizz_level_hard_capitale_europe_1.save!

quizz_level_easy_capitale_europe_2 = QuizzLevel.new(name: "Facile", quizz: quizz_capitale_europe_2)
quizz_level_easy_capitale_europe_2.save!

quizz_level_medium__capitale_europe_2 = QuizzLevel.new(name: "Moyen", quizz: quizz_capitale_europe_2)
quizz_level_medium__capitale_europe_2.save!

quizz_level_hard__capitale_europe_3 = QuizzLevel.new(name: "Difficile", quizz: quizz_capitale_europe_2)
quizz_level_hard__capitale_europe_3.save!

quizz_level_easy_capitale_europe_3 = QuizzLevel.new(name: "Facile", quizz: quizz_capitale_europe_3)
quizz_level_easy_capitale_europe_3.save!

quizz_level_medium_capitale_europe_3 = QuizzLevel.new(name: "Moyen", quizz: quizz_capitale_europe_3)
quizz_level_medium_capitale_europe_3.save!

quizz_level_hard_capitale_europe_3 = QuizzLevel.new(name: "Difficile", quizz: quizz_capitale_europe_3)
quizz_level_hard_capitale_europe_3.save!

quizz_level_easy_capitale_europe_4 = QuizzLevel.new(name: "Facile", quizz: quizz_capitale_europe_4)
quizz_level_easy_capitale_europe_4.save!

quizz_level_medium_capitale_europe_4 = QuizzLevel.new(name: "Moyen", quizz: quizz_capitale_europe_4)
quizz_level_medium_capitale_europe_4.save!

quizz_level_hard_capitale_europe_4 = QuizzLevel.new(name: "Difficile", quizz: quizz_capitale_europe_4)
quizz_level_hard_capitale_europe_4.save!

#questions / answers

quizz_capitale_europe_1_QA_1 = QuestionAnswer.new(question: "quelle est la cpitale de la France ?", answer: "Paris", quizz: quizz_capitale_europe_1)
quizz_capitale_europe_1_QA_1.save!

quizz_capitale_europe_1_QA_2 = QuestionAnswer.new(question: "quelle est la cpitale de l'Ireland' ?", answer: "Dublin", quizz: quizz_capitale_europe_1)
quizz_capitale_europe_1_QA_2.save!

quizz_capitale_europe_1_QA_3 = QuestionAnswer.new(question: "quelle est la cpitale de l'Allemagne ?", answer: "Berlin", quizz: quizz_capitale_europe_1)
quizz_capitale_europe_1_QA_3.save!

quizz_capitale_europe_1_QA_4 = QuestionAnswer.new(question: "quelle est la cpitale de l'Espagne' ?", answer: "Madrid", quizz: quizz_capitale_europe_1)
quizz_capitale_europe_1_QA_4.save!



# Pour quizz faire par ordre de populalation pour créer les paquets


######USER#####

anthony = User.new(
    name: "anthony",
    email: "anthony@gmail.gmail",
    password: "foobar",
    password_confirmation: "foobar",
    hp: 45,
    xp: 37,
    gem: 12,
    gold: 1100,
    level: 3
)
anthony.save!


#Level progress geography for anthony
anthony_geography_level_1_progress = ThemeLevelProgress.new(user: anthony, theme_level: geography_level_1, unlocked: true)
anthony_geography_level_1_progress.save!

anthony_geography_level_2_progress = ThemeLevelProgress.new(user: anthony, theme_level: geography_level_2, unlocked: false)
anthony_geography_level_2_progress.save!

anthony_geography_level_3_progress = ThemeLevelProgress.new(user: anthony, theme_level: geography_level_3, unlocked: false)
anthony_geography_level_3_progress.save!


#Subtheme progression for anthony, level 1 geography
anthony_europe_progress = SubthemeProgress.new(user: anthony, subtheme: europe, unlocked: true)
anthony_europe_progress.save!

anthony_africa_progress = SubthemeProgress.new(user: anthony, subtheme: africa, unlocked: true)
anthony_africa_progress.save!

anthony_america_progress = SubthemeProgress.new(user: anthony, subtheme: america, unlocked: true)
anthony_america_progress.save!

anthony_oceania_progress = SubthemeProgress.new(user: anthony, subtheme: oceania, unlocked: true)
anthony_oceania_progress.save!

anthony_asia_progress = SubthemeProgress.new(user: anthony, subtheme: asia, unlocked: true)
anthony_asia_progress.save!

anthony_caraibeean_progress = SubthemeProgress.new(user: anthony, subtheme: caraibeean, unlocked: false)
anthony_caraibeean_progress.save!


anthony_pacifica_progress = SubthemeProgress.new(user: anthony, subtheme: pacifica, unlocked: false)
anthony_pacifica_progress.save!


anthony_world_progress = SubthemeProgress.new(user: anthony, subtheme: world, unlocked: false)
anthony_world_progress.save!


#category progression for anthony, level 1 geography
anthony_capitale_europe_progress = CategoryProgress.new(user: anthony, category: capitale, unlocked: true)
anthony_capitale_europe_progress.save!

anthony_localization_europe_progress = CategoryProgress.new(user: anthony, category: localization, unlocked: true)
anthony_localization_europe_progress.save!

anthony_flag_europe_progress = CategoryProgress.new(user: anthony, category: flag, unlocked: true)
anthony_flag_europe_progress.save!


#quizz progression for anthony, europe capitale

anthony_quizz_capitale_europe_1_progress = QuizzProgress.new(user: anthony, quizz: quizz_capitale_europe_1, unlocked: true)
anthony_quizz_capitale_europe_1_progress.save!

anthony_quizz_capitale_europe_2_progress = QuizzProgress.new(user: anthony, quizz: quizz_capitale_europe_2, unlocked: true)
anthony_quizz_capitale_europe_2_progress.save!

anthony_quizz_capitale_europe_3_progress = QuizzProgress.new(user: anthony, quizz: quizz_capitale_europe_3, unlocked: false)
anthony_quizz_capitale_europe_3_progress.save!

anthony_quizz_capitale_europe_4_progress = QuizzProgress.new(user: anthony, quizz: quizz_capitale_europe_4, unlocked: false)
anthony_quizz_capitale_europe_4_progress.save!


#quizz level progress for anthony, europe capitale _1

anthony_quizz_capitale_europe_1_easy_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level_easy_capitale_europe_1, unlocked: true)
anthony_quizz_capitale_europe_1_easy_progress.save!

anthony_quizz_capitale_europe_1_medium_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level_easy_capitale_europe_1, unlocked: true)
anthony_quizz_capitale_europe_1_medium_progress.save!

anthony_quizz_capitale_europe_1_hard_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level_easy_capitale_europe_1, unlocked: false)
anthony_quizz_capitale_europe_1_hard_progress.save!

#quizz level records
anthony_quizz_capitale_europe_1_easy_record = Record.new(user: anthony, quizz_level: quizz_level_easy_capitale_europe_1, crown_or_sphere: "crown", completion: 2)
anthony_quizz_capitale_europe_1_easy_record.save!


anthony_quizz_capitale_europe_1_medium_record = Record.new(user: anthony, quizz_level: quizz_level_easy_capitale_europe_1, crown_or_sphere: "crown", completion: 1)
anthony_quizz_capitale_europe_1_medium_record.save!




#Flashcards for anthony

flashcard_1 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_1)
flashcard_1.save!

flashcard_2 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_2)
flashcard_2.save!

flashcard_3 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_3)
flashcard_3.save!

flashcard_4 = Flashcard.new(user: anthony, unlocked: true, trick: "penser à la tour", editable: false, easyness_factor: 1.2, repetition: 0, interval: 1, mistake_count: 0, question_answer: quizz_capitale_europe_1_QA_4)
flashcard_4.save!


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
