module LevelAndUserSeed
  def self.seed
    p "In levels.rb"

    level_xp = {
      1 => 50,
      2 => 70,
      3 => 100,
      4 => 140,
      5 => 180,
      6 => 220,
      7 => 270,
      8 => 330,
      9 => 390,
      10 => 470,
      11 => 550,
      12 => 640,
      13 =>  740,
      14 => 850,
      15 => 970,
      16 => 1110,
      17 => 1250,
      18 => 1410,
      19 => 1570,
      20 => 1760,
      21 => 1950,
      22 => 2160,
      23 => 2380,
      24 => 2620,
      25 => 2870,
      26 => 3140,
      27 => 3430,
      28 => 3730,
      29 => 4050,
      30 =>  4390
    }

    level1 = Level.new(level: 1,
                        required_xp: level_xp[1],
                        beginning_year:-2000000,
                        period:"Préhistoire",
                        sub_period: "Paléolithique ancien",
                        social_type: "Homo habilis")
    level1.save!

    level2 = Level.new(level: 2,
                        required_xp: level_xp[2],
                        beginning_year:-400000,
                        period:"Préhistoire",
                        sub_period: "Paléolithique moyen",
                        social_type: "Homo Néendertal")
    level2.save!
    level3 = Level.new(level: 3,
                        required_xp: level_xp[3],
                        beginning_year:-35000,
                        period:"Préhistoire",
                        sub_period: "Paléolithique supérieur",
                        social_type: "Homo Néendertal")
    level3.save!
    level4 = Level.new(level: 4,
                        required_xp: level_xp[4],
                        beginning_year:-10000,
                        period:"Préhistoire",
                        sub_period: "Mésolithique #1",
                        social_type: "Homo sapiens")
    level4.save!
    level5 = Level.new(level: 5,
                        required_xp: level_xp[5],
                        beginning_year:-8000,
                        period:"Préhistoire",
                        sub_period: "Mésolithique #2",
                        social_type: "Homo sapiens")
    level5.save!
    level6 = Level.new(level: 6,
                        required_xp: level_xp[6],
                        beginning_year:-7000,
                        period:"Préhistoire",
                        sub_period: "Mésolithique #3",
                        social_type: "Homo sapiens")
    level6.save!
    level7 = Level.new(level: 7,
                        required_xp: level_xp[7],
                        beginning_year:-6000,
                        period:"Préhistoire",
                        sub_period: "Néolithique ancien",
                        social_type: "Homo sapiens")
    level7.save!
    level8 = Level.new(level: 8,
                        required_xp: level_xp[8],
                        beginning_year:-4500,
                        period:"Préhistoire",
                        sub_period: "Néolithique moyen",
                        social_type: "Homo sapiens")
    level8.save!
    level9 = Level.new(level: 9,
                        required_xp: level_xp[9],
                        beginning_year:-3500,
                        period:"Préhistoire",
                        sub_period: "Néolithique final",
                        social_type: "Homo sapiens")
    level9.save!


    (10..29).each { |level|
      level9 = Level.new(level: level,
                        required_xp: level_xp[level],
                        beginning_year: "A completer",
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


    #  #####################################
    ########################################
    # HAIR

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/black_long_hair.png",
      name: "Cheveux longs noirs",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/black_short_hair.png",
      name: "Cheveux courts noirs",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "hair",
    #   img_src: "sprites/blond_short_hair.png",
    #   name: "Cheveux longs blonds",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "hair",
    #   img_src: "sprites/blond_short_hair.png",
    #   name: "Cheveux courts blonds",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/red_short_hair.png",
      name: "Cheveux courts rouges",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/red_short_hair.png",
      name: "Cheveux courts rouges",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/white_long_hair.png",
      name: "Cheveux longs blancs",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/white_short_hair.png",
      name: "Cheveux courts blancs",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/yellow_long_hair.png",
      name: "Cheveux courts jaunes",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/yellow_short_hair.png",
      name: "Cheveux courts jaunes",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # head


    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/brown_head.png",
      name: "Tête marron",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/green_head.png",
      name: "Tête verte",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "head",
    #   img_src: "sprites/white_head.png",
    #   name: "Tête blanche",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/orange_head.png",
      name: "Tête orange #1",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/light_yellow_head.png",
      name: "Tête jaune #2",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/red_head.png",
      name: "Tête rouge",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # helmet

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/black_turban.png",
      name: "Turban noir",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/brown_simple_helmet.png",
      name: "Casque marron simple",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/golden_helmet.png",
      name: "Casque en or",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/golden_red_helmet.png",
      name: "Casque en or et ruby",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/grey_helmet.png",
      name: "Casque simple",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/red_helmet.png",
      name: "Casque rouge",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!




    # Body

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_black.png",
      name: "Corps noir",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "body",
    #   img_src: "sprites/body_red.png",
    #   name: "Corps rouge",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_brown.png",
      name: "Corps marron",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_pink.png",
      name: "Corps rose",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/body_pink.png",
      name: "Corps rose",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/dark_grey_armor.png",
      name: "Armure grise",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/pink_reinforced_armor.png",
      name: "Armure rose de combat",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "body",
    #   img_src: "sprites/pink_armor.png",
    #   name: "Armure rose simple",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/purple_reinforced_armor.png",
      name: "Armure violette de combat",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "body",
    #   img_src: "sprites/purple_armor.png",
    #   name: "Armure violette simple",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "body",
    #   img_src: "sprites/red_reinforced_armor.png",
    #   name: "Armure rouge de combat",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/white_armor.png",
      name: "Armure blanche simple",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/white_reinforced_armor.png",
      name: "Armure blanche de combat",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "body",
    #   img_src: "sprites/yellow_armor.png",
    #   name: "Armure jaune simple",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/yellow_reinforced_armor.png",
      name: "Armure jaune de combat",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!


    # Weapon

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/bowl_axe.png",
      name: "Fléau de combat",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/double_axe.png",
      name: "Double hache",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/golden_sword.png",
      name: "Epée en or",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/little_knife.png",
      name: "Pierre taillée",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/red_sword.png",
      name: "Epée rouge",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!


    # Shield

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/brown_little_shield.png",
      name: "Bouclier en bois",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/brown_white_little_shield.png",
      name: "Bouclier en bois certifié",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "weapon",
    #   img_src: "sprites/circle_brown_shield.png",
    #   name: "Bouclier en bois renforcé",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/dark_little_shield.png",
      name: "Bouclier noir",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/golden_white_shield.png",
      name: "Bouclier de chevalier",
      unlocked_condition: "none",
      price: 0
    )
    character_item.save!

    # character_item = CharacterItem.new(
    #   item_type: "weapon",
    #   img_src: "sprites/red_golden_white_shield.png",
    #   name: "Bouclier sacré",
    #   unlocked_condition: "none",
    #   price: 0
    # )
    # character_item.save!

    CharacterItem.all.each do |character_item|
      user_character_item = UserCharacterItem.new(
        user: anthony,
        character_item: character_item,
        unlocked: true,
        bought: true
      )
      user_character_item.save!
    end

    character = Character.new(
      user: anthony,
      background: "purple",
      body: "sprites/body_brown.png",
      hair: "sprites/long_hair_black.png",
      head: "sprites/head_white.png",
      weapon: "",
      helmet: "",
      shield: ""
    )
    character.save!


  end
end
