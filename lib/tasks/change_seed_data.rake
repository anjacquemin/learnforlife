desc "Change all but global achievements, adding category and theme id"
task :change_achievements => :environment do
  achievements_to_change = Achievement.where.not(achievement_category: "global")
  achievements_to_change.each do |achievement_to_change|
    achievement_to_change.achievement_category = "Theme"
    if achievement_to_change.achievement_type == "category"
      if achievement_to_change.img_src == "movie-start.png"
        achievement_to_change.category = Category.find_by(name: "culture générale")
      elsif achievement_to_change.img_src == "gopro.png"
        achievement_to_change.category = Category.find_by(name: "Producteur")
      elsif achievement_to_change.img_src == "academy-award.png"
        achievement_to_change.category = Category.find_by(name: "Oscar meilleur film")
      elsif achievement_to_change.img_src == "clapperboard.png"
        achievement_to_change.category = Category.find_by(name: "Année")
      elsif achievement_to_change.img_src == "actor.png"
        achievement_to_change.category = Category.find_by(name: "Acteur")
      elsif achievement_to_change.img_src == "map.png"
        achievement_to_change.category = Category.find_by(name: "Localisation")
      elsif achievement_to_change.img_src == "flag.png"
        achievement_to_change.category = Category.find_by(name: "Drapeaux")
      elsif achievement_to_change.img_src == "tour-eiffel.png"
        achievement_to_change.category = Category.find_by(name: "Capitales")
      end
    end
    if achievement_to_change.category
      achievement_to_change.theme = achievement_to_change.category.theme
    elsif achievement_to_change.name.split.include?("Cinema")
      achievement_to_change.theme = Theme.find_by(name: "Cinema")
    elsif achievement_to_change.name.split.include?("Geographie")
      achievement_to_change.theme = Theme.find_by(name: "Geographie")
    elsif achievement_to_change.name.split.include?("Période historique")
      achievement_to_change.theme = Theme.find_by(name: "Période historique")
    end
    achievement_to_change.save!
  end
end

desc "Orthograph change : theme name + cinema category"
task :change_orthograph => :environment do
  geo = Theme.find_by(name: "Geographie")
  geo.name = "Géographie"
  geo.save!
  cine = Theme.find_by(name: "Cinema")
  cine.name = "Cinéma"
  cine.save!
  producteur = Category.find_by(name: "Producteur")
  producteur.name = "Réalisateur"
  producteur.save!
end

desc "Change movies year questions"
task :change_movies_questions => :environment do
  Category.find_by(name: "Année").question_answers.each do |question_answer|
    p "question #{question_answer.question}"
    question_answer.question.gsub!("En quelle année a été réalisé", "En quelle année est sorti")
    question_answer.save!
    p "question #{question_answer.question}"
  end
end

desc "Change achievement name (accents)"
task :change_achievement_accents => :environment do
  achievements_to_change = Achievement.where.not(achievement_category: "global")
  achievements_to_change.each do |achievement_to_change|
    achievement_to_change.name.gsub!("Cinema", "Cinéma")
    achievement_to_change.name.gsub!("Geographie", "Géographie")
    achievement_to_change.name.gsub!("culture générale", "Culture Générale")
    p "achievement_to_change #{achievement_to_change.name}"
    achievement_to_change.save!
  end
end
