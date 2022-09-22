class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    data = JSON.parse(params["json"])
    p data
    p sign_up_params
    build_resource({
      name: data["user"]["name"],
      email: data["user"]["email"],
      password: data["user"]["password"],
      password_confirmation: data["user"]["password_confirmation"],
      level: Level.find_by(level: 1)
    })

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        seed_all_records(resource)
        respond_to do |format|
          format.json { render json: { location: after_sign_up_path_for(resource) } }
        end
        # respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      # override respond_with resource
      # https://stackoverflow.com/questions/6240141/devise-redirect-on-sign-up-failure
      # flash.now[:alert] = resource.errors.full_messages.join(", ")
      respond_to do |format|
        format.json
      end
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end


    def after_sign_up_path_for(resource_or_scope)
      themes_path
    end

    def after_inactive_sign_up_path_for(resource_or_scope)
      themes_path
    end

    def seed_all_records(user)
      character_items_seed(user)
      character_progresses_seed(user)
      character_achievements_seed(user)
    end

    def character_items_seed(user)

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

    def character_progresses_seed(user)

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

    def character_achievements_seed(user)
      Achievement.all.each do |achievement|
        user_achievement = UserAchievement.new(user: user, achievement: achievement, unlocked: false)
        user_achievement.save!
      end
    end
end
