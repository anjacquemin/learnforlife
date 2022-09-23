module MassUserSeed
  def self.seed
    (1..99).each do |i|
      anthony = User.new(
        name: "caaa#{i}",
        email: "aaaa#{i}@gmail.gmail",
        password: "foobar",
        password_confirmation: "foobar",
        hp: 50,
        hp_max: 50,
        xp: 0,
        gem: 0,
        gold: 0,
        level: Level.find_by(level: 1)
      )
      anthony.save!
    end
    User.all.each do |user|
      # character_items_seed(user)
      # character_progresses_seed(user)
      # character_achievements_seed(user)
      quizzs_completion_seed(user)
    end
  end

  def self.character_items_seed(user)
    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Red long hair"),
      unlocked: true
    )
    user_character_item.save!

    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Blond long hair"),
      unlocked: true
    )
    user_character_item.save!

    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Black long hair"),
      unlocked: true
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_black.png",
      name: "Black body"
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Black body"),
      unlocked: true
    )
    user_character_item.save!

    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Brown body"),
      unlocked: true
    )
    user_character_item.save!

    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Pink body"),
      unlocked: true
    )
    user_character_item.save!


    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "Yellow head"),
      unlocked: true
    )
    user_character_item.save!

    user_character_item = UserCharacterItem.new(
      user: user,
      character_item: CharacterItem.find_by(name: "White head"),
      unlocked: true
    )
    user_character_item.save!


    character = Character.new(
      user: user,
      background: "purple",
      body: "sprites/body_brown.png",
      hair: "sprites/long_hair_black.png",
      head: "sprites/head_white.png"
    )
    character.save!

    CharacterItem.all.each do |character_item|
      if UserCharacterItem.where(user: user).where(character_item: character_item).size == 0
        user_character_item = UserCharacterItem.new(
          user: user,
          character_item: character_item,
          unlocked: false
        )
        user_character_item.save!
      end
    end
  end

  def self.character_progresses_seed(user)

    ThemeLevel.all.each do |theme_level|
      unlocked = (theme_level.level == 1)
      theme_level_progress = ThemeLevelProgress.new(user: user, theme_level: theme_level, unlocked: unlocked)
      theme_level_progress.save!
    end

    Subtheme.all.each do |subtheme|
      unlocked = (subtheme.theme_level.level == 1)
      subtheme_progress = SubthemeProgress.new(user: user, subtheme: subtheme, unlocked: unlocked)
      subtheme_progress.save!
    end

    Category.all.each do |category|
      # unlocked = (category.subtheme.theme_level.level == 1)
      category_progress = CategoryProgress.new(user: user, category: category, unlocked: false)
      category_progress.save!
    end

    Quizz.all.each do |quizz|
      unlocked = (quizz.ordering == 1 && quizz.theme_level.level == 1)
      quizz_progress = QuizzProgress.new(user: user, quizz: quizz, unlocked: unlocked)
      quizz_progress.save!
    end

    QuizzLevel.all.each do |quizz_level|
      unlocked = (quizz_level.quizz.ordering == 1 && quizz_level.quizz.theme_level.level == 1 && quizz_level.name == "Facile")
      quizz_level_progress = QuizzLevelProgress.new(user: user, quizz_level: quizz_level, unlocked: unlocked)
      quizz_level_progress.save!
    end
  end

  def self.character_achievements_seed(user)
    Achievement.all.each do |achievement|
      user_achievement = UserAchievement.new(user: user, achievement: achievement, unlocked: false)
      user_achievement.save!
    end
  end

  def self.quizzs_completion_seed(user)
    record = Record.new(
      user: user,
      quizz_level: QuizzLevel.first,
      seconds_duration: (30..100).to_a.sample(),
      milliseconds_duration: (30..100).to_a.sample(),
      completion: 3,
      crown_or_sphere: "crown",
      score_percentage: 100,
      dealt_with: true
    )
    record.save!
    best_record = BestRecord.new(quizz_level: record.quizz_level, record: record, theme: record.theme)
    best_record.save!

  end
end
