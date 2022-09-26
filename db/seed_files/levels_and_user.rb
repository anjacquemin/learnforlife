module LevelAndUserSeed
  def self.seed
    p "In levels.rb"

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


    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/long_hair_red.png",
      name: "Red long hair",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: false
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/long_hair_blond.png",
      name: "Blond long hair",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: false
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/long_hair_black.png",
      name: "Black long hair",
      unlocked_condition: "none",
      price: 1
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: false
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_black.png",
      name: "Black body",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: true
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_brown.png",
      name: "Brown body",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: true
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_pink.png",
      name: "Pink body",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: true
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/head_yellow.png",
      name: "Yellow head",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: true
    )
    user_character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/head_white.png",
      name: "White head",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!
    user_character_item = UserCharacterItem.new(
      user: anthony,
      character_item: character_item,
      unlocked: true,
      bought: false
    )
    user_character_item.save!


    type = ["head", "body", "hair", "weapon"]
    100.times do
      character_item = CharacterItem.new(
        item_type: type.sample(),
        img_src: "sprites/head_white.png",
        name: "White head",
        price: [1,2,3,4].sample(),
        unlocked_condition: "random condition"
      )
      character_item.save!
      user_character_item = UserCharacterItem.new(
        user: anthony,
        character_item: character_item,
        unlocked: [false,true].sample(),
        bought: false
      )
      user_character_item.save!
    end

    character = Character.new(
      user: anthony,
      background: "purple",
      body: "sprites/body_brown.png",
      hair: "sprites/long_hair_black.png",
      head: "sprites/head_white.png"
    )
    character.save!


  end
end
