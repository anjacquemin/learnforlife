module AchievementSeed
  def self.seed
    anthony = User.find_by(name:"anthony")

    #achievements
    achievement_1 = Achievement.new(
      name: "Savoir niveau 1",
      unlocked_conditions: "Obtenir 50 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "50"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 2",
      unlocked_conditions: "Obtenir 100 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "100"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 3",
      unlocked_conditions: "Obtenir 200 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "200"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 4",
      unlocked_conditions: "Obtenir 500 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "500"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 5",
      unlocked_conditions: "Obtenir 1000 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "1000"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 6",
      unlocked_conditions: "Obtenir 2000 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "2000"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 7",
      unlocked_conditions: "Obtenir 5000 couronnes",
      achievement_type: "crown_count",
      achievement_category: "global",
      img_src: "crown.png",
      count: "5000"
      )
    achievement_1.save!
    achievement_1 = Achievement.new(
      name: "Savoir niveau 8",
      unlocked_conditions: "Obtenir 10000 couronnes",
      achievement_type: "global",
      img_src: "crown.png.png",
      count: "10000"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 1",
      unlocked_conditions: "Obtenir 1 sphère de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "1"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 2",
      unlocked_conditions: "Obtenir 5 sphères de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "5"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 3",
      unlocked_conditions: "Obtenir 10 sphères de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "10"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 4",
      unlocked_conditions: "Obtenir 20 sphère de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "20"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 5",
      unlocked_conditions: "Obtenir 50 sphère de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "50"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 6",
      unlocked_conditions: "Obtenir 100 sphère de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "100"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 7",
      unlocked_conditions: "Obtenir 200 sphère de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "200"
      )
    achievement_1.save!

    achievement_1 = Achievement.new(
      name: "Maitre du savoir niveau 8",
      unlocked_conditions: "Obtenir 500 sphère de connaissance",
      achievement_type: "sphere_count",
      achievement_category: "global",
      img_src: "sphere.png",
      count: "500"
      )
    achievement_1.save!


    Theme.all.each do |theme|
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 1",
        unlocked_conditions: "Obtenir plus de 25% des couronnes de la thématique #{theme.name}",
        achievement_type: "crown_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "25%"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 2",
        unlocked_conditions: "Obtenir plus de 50% des couronnes de la thématique #{theme.name}",
        achievement_type: "crown_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "50%"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 3",
        unlocked_conditions: "Obtenir plus de 75% des couronnes de la thématique #{theme.name}",
        achievement_type: "crown_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "75%"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 4",
        unlocked_conditions: "Obtenir 100% des couronnes de la thématique #{theme.name}",
        achievement_type: "crown_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "100%"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Maitre savoir #{theme.name} de niveau 1",
        unlocked_conditions: "Obtenir 1 sphères de connaissance de la thématique #{theme.name}",
        achievement_type: "sphere_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "1"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 2",
        unlocked_conditions: "Obtenir plus de 50% des sphères de connaissance de la thématique #{theme.name}",
        achievement_type: "sphere_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "50%"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 3",
        unlocked_conditions: "Obtenir plus de 75% des sphères de connaissance de la thématique #{theme.name}",
        achievement_type: "sphere_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "75%"
        )
      achievement_1.save!
      achievement_1 = Achievement.new(
        name: "Savoir #{theme.name} de niveau 4",
        unlocked_conditions: "Obtenir 100% des sphères de connaissance de la thématique #{theme.name}",
        achievement_type: "sphere_percentage",
        achievement_category: theme.name,
        img_src: theme.image_src,
        count: "100%"
        )
      achievement_1.save!
    end

    Achievement.all.each do |achievement|
      anthony_achievemnt_1 = UserAchievement.new(achievement: achievement, unlocked:false, user: anthony)
      anthony_achievemnt_1.save!
    end
  end
end
