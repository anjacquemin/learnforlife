# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# the ../ just removes `seeds.rb` filename from the path which is given by __FILE__

puts 'seed'
require File.expand_path('../seed_files/levels_and_user', __FILE__)
require File.expand_path('../seed_files/themes', __FILE__)
require File.expand_path('../seed_files/quizzs', __FILE__)
require File.expand_path('../seed_files/achievements', __FILE__)


UserAchievement.destroy_all
Achievement.destroy_all
# Character.destroy_all
# UserCharacterItem.destroy_all
# CharacterItem.destroy_all
# FlashcardSave.destroy_all
# BestRecord.destroy_all
# QuizzLevelProgress.destroy_all
# UserAnswer.destroy_all
# Record.destroy_all
# QuizzAnswer.destroy_all
# User.destroy_all
# Level.destroy_all
# QuizzQuestionAnswer.destroy_all
# QuestionAnswer.destroy_all
# QuizzLevel.destroy_all
# Quizz.destroy_all
# Category.destroy_all
# Subtheme.destroy_all
# ThemeLevel.destroy_all
# Theme.destroy_all


# LevelAndUserSeed::seed
# p "end level seed"

# ThemesSeed::seed
# p "end themes seed"

# QuizzSeed::seed
# p "end quizzs seed"

AchievementSeed::seed
p "end quizzs seed"



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
