
module CinemaThemeSeed
  def self.seed


    _IMAGE_DIR_ = "./app/assets/images/"

    anthony = User.find_by(name:"anthony")

    cinema = Theme.new(name: "Cinema")
    cinema.image_src = '<i class="fas fa-atlas"> </i>'
    cinema.adventure_only = false
    cinema.save!


    # Geography levels

    level_1 = ThemeLevel.new(
        name: "Niveau 1",
        level: 1,
        objective: "Débloque les <strong>badges oscars</strong>, <strong>Culture Générale</strong>, <strong>Année</strong>, <strong>Acteur</strong> et <strong>Réalisateur</strong>  de niveau 1 pour accéder au <strong>niveau 2 Cinéma</strong> !",
        theme: cinema)
    level_1.save!

    level_2 = ThemeLevel.new(
        name: "Niveau 2",
        level: 2,
        objective: "Débloque les <strong>badges oscars</strong>, <strong>Culture Générale</strong>, <strong>Année</strong>, <strong>Acteur</strong> et <strong>Réalisateur</strong>  de niveau 2 pour accéder au <strong>niveau 3 Cinéma</strong> !",
        theme: cinema)
    level_2.save!

    level_3 = ThemeLevel.new(
        name: "Niveau 3",
        level: 3,
        objective: "Débloque les <strong>badges oscars</strong>, <strong>Culture Générale</strong>, <strong>Année</strong>, <strong>Acteur</strong> et <strong>Réalisateur</strong>  de niveau 3 pour accéder au <strong>niveau 4 Cinéma</strong> !",
        theme: cinema)
    level_3.save!


    level_4 = ThemeLevel.new(
        name: "Niveau 4",
        level: 4,
        objective: "Obtiens des sphères de connaissances Cinéma</strong> !",
        theme: cinema)
    level_4.save!



    # Geography subtheme
    subthemes = []
    movies2004 = Subtheme.new(name: "Films 1990 - 2004", theme_level: level_1)
    movies2004.save!

    movies2022 = Subtheme.new(name: "Films 2005 - 2022", theme_level: level_1)
    movies2022.save!

    movies1989 = Subtheme.new(name: "Films 1960 - 1989", theme_level: level_2)
    movies1989.save!

    movies1960 = Subtheme.new(name: "Films < 1960", theme_level: level_3)
    movies1960.save!

    oscar1960 = Subtheme.new(name: "Oscar < 1960", theme_level: level_3)
    oscar1960.save!

    oscar1989 = Subtheme.new(name: "Oscar 1960-1989", theme_level: level_2)
    oscar1989.save!

    oscar2022 = Subtheme.new(name: "Oscar 1990-2022", theme_level: level_1)
    oscar2022.save!


    cultureg1 = Subtheme.new(name: "Culture G #1", theme_level: level_1)
    cultureg1.save!

    cultureg2 = Subtheme.new(name: "Culture G #2", theme_level: level_2)
    cultureg2.save!

    cultureg3 = Subtheme.new(name: "Culture G #3", theme_level: level_3)
    cultureg3.save!

    all_movies = Subtheme.new(name: "Films", theme_level: level_4)
    all_movies.save!

    all_oscars = Subtheme.new(name: "Oscar", theme_level: level_4)
    all_oscars.save!

    all_culture = Subtheme.new(name: "Culture G", theme_level: level_4)
    all_culture.save!



    #Level progress geography for anthony

    ThemeLevel.all.each_with_index do |theme_level, index|
      unlocked = (index == 0)
      anthony_level_1_progress = ThemeLevelProgress.new(user: anthony, theme_level: level_1, unlocked: unlocked)
      anthony_level_1_progress.save!
    end

    #Subtheme progression for anthony, level 1 geography
    unlocked_subthemes_progress = [cultureg1, oscar2022, movies2022, movies2004]

    subthemes = cinema.subthemes

    subthemes.each do |subtheme|
      unlocked = (unlocked_subthemes_progress.include?(subtheme))
      subtheme_progress = SubthemeProgress.new(user: anthony, subtheme: subtheme, unlocked: unlocked)
      subtheme_progress.save!
    end

    category_img = {
      "Oscar meilleur film".to_sym => "academy-award.png",
      "culture générale".to_sym => "movie-start.png",
      "Année".to_sym => "clapperboard.png",
      "Acteur".to_sym => "actor.png",
      "Producteur".to_sym => "gopro.png"
    }

    # Seed all categories for last level

    category_record = Category.new(subtheme: all_oscars, name: "Oscar meilleur film", objective: "Remporte des sphères de connaissance !", ordering: 1, img_src: category_img["Oscar meilleur film".to_sym])
    category_record.save!
    category_progress = CategoryProgress.new(user: anthony, category: category_record, unlocked: false)
    category_progress.save!

    category_record = Category.new(subtheme: all_culture, name: "culture générale", objective: "Remporte des sphères de connaissance !", ordering: 1, img_src: category_img["culture générale".to_sym])
    category_record.save!
    category_progress = CategoryProgress.new(user: anthony, category: category_record, unlocked: false)
    category_progress.save!

    category_record = Category.new(subtheme: all_movies, name: "Année", objective: "Remporte des sphères de connaissance !", ordering: 1, img_src: category_img["Année".to_sym])
    category_record.save!
    category_progress = CategoryProgress.new(user: anthony, category: category_record, unlocked: false)
    category_progress.save!

    category_record = Category.new(subtheme: all_movies, name: "Acteur", objective: "Remporte des sphères de connaissance !", ordering: 3, img_src: category_img["Acteur".to_sym])
    category_record.save!
    category_progress = CategoryProgress.new(user: anthony, category: category_record, unlocked: false)
    category_progress.save!

    category_record = Category.new(subtheme: all_movies, name: "Producteur", objective: "Remporte des sphères de connaissance !", ordering: 2, img_src: category_img["Producteur".to_sym])
    category_record.save!
    category_progress = CategoryProgress.new(user: anthony, category: category_record, unlocked: false)
    category_progress.save!


    cinema.theme_levels.last.categories.each do |category_record|
      quizz = Quizz.new(category: category_record, name: "MASTER", ordering: 1, crown_or_sphere: "sphere")
      quizz.save!

      quizz_progress = QuizzProgress.new(user: anthony, quizz: quizz, unlocked: false)
      quizz_progress.save!

      ["Facile", "Moyen", "Difficile"].each do |level|
        quizz_level = QuizzLevel.new(name: level, quizz: quizz, crown_or_sphere: "sphere")
        quizz_level.save!

        quizz_level_progress = QuizzLevelProgress.new(user: anthony, quizz_level: quizz_level, unlocked: false)
        quizz_level_progress.save!
      end
    end

  end
end
