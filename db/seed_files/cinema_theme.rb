
module CinemaThemeSeed
  def self.seed

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

    anthony = User.new(
      name: "anthony",
      email: "anthony@gmail.gmail",
      password: "foobar",
      password_confirmation: "foobar",
      hp: 50,
      hp_max: 50,
      xp: 0,
      gem: 0,
      gold: 0,
      level: level1,
      admin: true
    )
    anthony.save!

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
    movies2004 = Subtheme.new(name: "Films 1990-2004", theme_level: level_1)
    movies2004.save!

    movies2022 = Subtheme.new(name: "Films 2005-2022", theme_level: level_1)
    movies2022.save!

    movies1989 = Subtheme.new(name: "Films 1960-1989", theme_level: level_2)
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
  end
end
