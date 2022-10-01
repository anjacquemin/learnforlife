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
                        beginning_year:-2400000,
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


    (10..100).each { |level|
      level9 = Level.new(level: level,
                        required_xp: level_xp[level] || 100000,
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
      img_src: "sprites/hairs/black_long_hair.png",
      name: "Cheveux longs noirs",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/black_short_hair.png",
      name: "Cheveux courts noirs",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/black_short_hair_2.png",
      name: "Cheveux courts noirs",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    #

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/blond_long_hair.png",
      name: "Cheveux longs blond",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/blond_short_hair.png",
      name: "Cheveux courts blond",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/blond_short_hair_2.png",
      name: "Cheveux courts blond",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    #
    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/red_long_hair.png",
      name: "Cheveux longs rouge",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/red_short_hair.png",
      name: "Cheveux courts rouge",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/red_short_hair_2.png",
      name: "Cheveux courts rouge",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    #

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/white_long_hair.png",
      name: "Cheveux longs blanc",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/white_short_hair.png",
      name: "Cheveux courts blanc",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "hair",
      img_src: "sprites/hairs/white_short_hair_2.png",
      name: "Cheveux courts blanc",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    # head

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/bold_brown_head.png",
      name: "Tête plus marron",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/brown_head.png",
      name: "Tête marron",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/light_brown_head.png",
      name: "Tête marron",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/light_yellow_head.png",
      name: "Tête jaune",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/orange_head.png",
      name: "Tête orange",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/red_head.png",
      name: "Tête rouge",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "head",
      img_src: "sprites/heads/very_light_brown_head.png",
      name: "Tête légerement marron",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!


    # helmet

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/black_turban.png",
      name: "Turban noir",
      unlocked_condition: "Prérequis : niveau 5",
      level: Level.find_by(level: 5),
      price: 1000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/black_turban_2.png",
      name: "Turban noir 2",
      unlocked_condition: "Prérequis : niveau 8",
      level: Level.find_by(level: 8),
      price: 2000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/brown_simple_helmet.png",
      name: "Casque marron simple",
      unlocked_condition: "Prérequis : niveau 10",
      level: Level.find_by(level: 12),
      price: 3000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/flower.png",
      name: "Fleur",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/golden_crown_2.png",
      name: "Casque en or massif",
      unlocked_condition: "Prérequis : niveau 50",
      level: Level.find_by(level: 50),
      price: 50000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/golden_helmet.png",
      name: "Casque en or",
      unlocked_condition: "Prérequis : niveau 40",
      level: Level.find_by(level: 40),
      price: 40000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/golden_red_helmet.png",
      name: "Casque en or certi d'un ruby",
      unlocked_condition: "Prérequis : niveau 60",
      level: Level.find_by(level: 60),
      price: 60000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/grey_helmet.png",
      name: "Casque renforcé",
      unlocked_condition: "Prérequis : niveau 25",
      level: Level.find_by(level: 25),
      price: 10000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/grey_simple_helmet.png",
      name: "Casque simple",
      unlocked_condition: "Prérequis : niveau 18",
      level: Level.find_by(level: 18),
      price: 8000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "helmet",
      img_src: "sprites/helmets/red_helmet.png",
      name: "Casque de feu",
      unlocked_condition: "Prérequis : niveau 32",
      level: Level.find_by(level: 32),
      price: 25000
    )
    character_item.save!


    # Body

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/black_armor.png",
      name: "Armure simple",
      unlocked_condition: "Prérequis : niveau 20",
      level: Level.find_by(level: 20),
      price: 20000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/black_tunique.png",
      name: "Tunique noire",
      unlocked_condition: "Prérequis : niveau 5",
      level: Level.find_by(level: 5),
      price: 1500
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/blue_body.png",
      name: "corps bleu",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/blue_body_2.png",
      name: "corps bleu 2",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/golden_armor.png",
      name: "Armure de chevalier",
      unlocked_condition: "Prérequis : niveau 45",
      level: Level.find_by(level: 45),
      price: 35000
    )
    character_item.save!


    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/green_tunique.png",
      name: "tunique vert",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!


    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/green_tunique_2.png",
      name: "tunique verte 2",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!


    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/grey_armor.png",
      name: "Armure renforcée",
      unlocked_condition: "Prérequis : niveau 50",
      level: Level.find_by(level: 28),
      price: 25000
    )
    character_item.save!


    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/pink_body.png",
      name: "corps rose",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!


    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/pink_body_2.png",
      name: "corps rose 2",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/red_armor.png",
      name: "Armure de feu",
      unlocked_condition: "Prérequis : niveau 55",
      level: Level.find_by(level: 55),
      price: 100000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/white_body.png",
      name: "Corps blanc",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/white_body_2.png",
      name: "Corps blanc #2",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "body",
      img_src: "sprites/bodys/yellow_tunique.png",
      name: "Tunique jaune",
      unlocked_condition: "none",
      level: Level.find_by(level:1),
      price: 0
    )
    character_item.save!


    # Weapon

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/bowl_axe.png",
      name: "Fléau de combat",
      unlocked_condition: "Prérequis : niveau 22",
      level: Level.find_by(level: 22),
      price: 15000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/double_axe.png",
      name: "Double hache",
      unlocked_condition: "Prérequis : niveau 24",
      level: Level.find_by(level: 24),
      price: 18000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/golden_sword.png",
      name: "Epée en or",
      unlocked_condition: "Prérequis : niveau 42",
      level: Level.find_by(level: 42),
      price: 42000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/little_knife.png",
      name: "Pierre taillée",
      unlocked_condition: "Prérequis : niveau 5",
      level: Level.find_by(level: 3),
      price: 800
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/red_sword.png",
      name: "Epée de feu",
      unlocked_condition: "Prérequis : niveau 42",
      level: Level.find_by(level: 42),
      price: 50000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/simple_sword.png",
      name: "Epée de combat",
      unlocked_condition: "Prérequis : niveau 33",
      level: Level.find_by(level: 33),
      price: 25000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "weapon",
      img_src: "sprites/weapons/blue_sword.png",
      name: "Epée de glace",
      unlocked_condition: "Prérequis : niveau 70",
      level: Level.find_by(level: 70),
      price: 150000
    )
    character_item.save!


    # Shield

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/big_red_shield.png",
      name: "Bouclier de feu",
      unlocked_condition: "Prérequis : niveau 35",
      level: Level.find_by(level: 35),
      price: 30000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/brown_little_shield.png",
      name: "Bouclier léger en bois certifié",
      unlocked_condition: "Prérequis : niveau 7",
      level: Level.find_by(level: 15),
      price: 2000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/brown_white_little_shield.png",
      name: "Bouclier en bois certifié",
      unlocked_condition: "Prérequis : niveau 33",
      level: Level.find_by(level: 33),
      price: 7000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/circle_brown_little_shield.png",
      name: "Bouclier rond en bois",
      unlocked_condition: "Prérequis : niveau 16",
      level: Level.find_by(level: 16),
      price: 5000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/dark_little_shield.png",
      name: "Bouclier en fer forgé",
      unlocked_condition: "Prérequis : niveau 33",
      level: Level.find_by(level: 24),
      price: 13000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/golden_white_shield.png",
      name: "Grand bouclier de chevalier",
      unlocked_condition: "Prérequis : niveau 36",
      level: Level.find_by(level: 36),
      price: 20000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/big_red_shield.png",
      name: "Bouclier de feu",
      unlocked_condition: "Prérequis : niveau 60",
      level: Level.find_by(level: 60),
      price: 50000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/white_brown_shield.png",
      name: "Bouclier en bois renforcé",
      unlocked_condition: "Prérequis : niveau 19",
      level: Level.find_by(level: 19),
      price: 14000
    )
    character_item.save!

    character_item = CharacterItem.new(
      item_type: "shield",
      img_src: "sprites/shields/white_shield.png",
      name: "Bouclier certi",
      unlocked_condition: "Prérequis : niveau 20",
      level: Level.find_by(level: 20),
      price: 20000
    )
    character_item.save!

    CharacterItem.all.each do |character_item|
      if character_item.level.level == 1
        user_character_item = UserCharacterItem.new(
          user: anthony,
          character_item: character_item,
          unlocked: true,
          bought: true
        )
      else
        user_character_item = UserCharacterItem.new(
          user: anthony,
          character_item: character_item,
          unlocked: false,
          bought: false
        )
      end
      user_character_item.save!
    end

    character = Character.new(
      user: anthony,
      background: "purple",
      body: "sprites/bodys/white_body.png",
      hair: "sprites/hairs/black_long_hair.png",
      head: "sprites/heads/light_brown_head.png",
      weapon: "sprites/weapons/empty.png",
      helmet: "sprites/helmets/empty.png",
      shield: "sprites/shields/empty.png"
    )
    character.save!


  end
end
