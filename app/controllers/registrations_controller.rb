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
        UserMailer.with(user: @user).welcome_email.deliver_later
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

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      # respond_with resource
      render "pages/parameters"
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end


    def after_sign_up_path_for(resource_or_scope)
      themes_path
    end

    def after_sign_up_path_for(resource_or_scope)
      themes_path
    end

    def after_update_path_for(resource_or_scope)
      parameters_path
    end

    def seed_all_records(user)
      character_items_seed(user)
      character_progresses_seed(user)
      character_achievements_seed(user)
    end

    def character_items_seed(user)
      CharacterItem.all.each do |character_item|
        if character_item.level.level == 1
          user_character_item = UserCharacterItem.new(
            user: user,
            character_item: character_item,
            unlocked: true,
            bought: true
          )
        else
          user_character_item = UserCharacterItem.new(
            user: user,
            character_item: character_item,
            unlocked: false,
            bought: false
          )
        end
        user_character_item.save!
      end
      character = Character.new(
        user: user,
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
