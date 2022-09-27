
module ThemesSeed
  def self.seed

    _IMAGE_DIR_ = "./app/assets/images/"

    anthony = User.find_by(name:"anthony")

    geography = Theme.new(name: "Geographie")
    geography.image_src = '<i class="fas fa-atlas"> </i>'
    geography.adventure_only = false
    geography.save!

    history = Theme.new(name: "Histoire")
    history.image_src = '<i class="fas fa-atlas"> </i>'
    history.adventure_only = false
    history.save!

    mnemotechnique = Theme.new(name: "Mnemotechnie")
    mnemotechnique.image_src = '<i class="fas fa-atlas"> </i>'
    mnemotechnique.adventure_only = false
    mnemotechnique.save!

    sports = Theme.new(name: "Sports")
    sports.image_src = '<i class="fas fa-atlas"> </i>'
    sports.adventure_only = false
    sports.save!

    # Geography levels

    geography_level_1 = ThemeLevel.new(
        name: "niveau 1",
        level: 1,
        objective: "Débloque tous les <strong>badges Capitales</strong>, <strong>Localisation</strong> et <strong>Drapeaux</strong> de niveau 1 pour accéder au <strong>niveau 2 Géographie</strong> !",
        theme: geography)
    geography_level_1.save!

    geography_level_2 = ThemeLevel.new(
        name: "Niveau 2",
        level: 2,
        objective: "Débloque tous les <strong>badges Capitales</strong>, <strong>Localisation</strong> et <strong>Drapeaux</strong> de niveau 2 pour accéder au <strong>niveau 3 Géographie</strong> !",
        theme: geography)
    geography_level_2.save!


    geography_level_3 = ThemeLevel.new(
        name: "Niveau 3",
        level: 3,
        objective: "Débloque tous les <strong>badges Capitales</strong>, <strong>Localisation</strong> et <strong>Drapeaux</strong> de niveau 3 pour <strong>collecter des sphères de connaissances niveau 3 Géographie</strong> !",
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
      capitale = Category.new(subtheme: subtheme, name: "Capitales", objective: "Obtiens <strong>2 couronnes</strong> au quizz <strong>Capitale #{subtheme.name} Master</strong> niveau <strong>moyen</strong> pour obtenir le <strong>badge capitale</strong>", ordering: 1, img_src: 'tour-eiffel.png')
      capitale.save!
      categories << capitale

      localization = Category.new(subtheme: subtheme, name: "Localisation", objective: "Obtiens <strong>2 couronnes</strong> au quizz <strong>Localisation #{subtheme.name} Master</strong> niveau <strong>moyen</strong> pour obtenir le <strong>badge localisation</strong>", ordering: 2, img_src: "map.png")
      localization.save!
      categories << localization

      flag = Category.new(subtheme: subtheme, name: "Drapeaux", objective: "Obtiens <strong>2 couronnes</strong> au quizz <strong>Drapeaux #{subtheme.name} Master</strong> niveau <strong>moyen</strong> pour obtenir le <strong>badge drapeau</strong>", ordering: 3, img_src: "flag.png")
      flag.save!
      categories << flag
    end
  end
end
