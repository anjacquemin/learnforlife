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

    p "djzai: #{resource}"

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        p "ICI"
        p after_sign_up_path_for(resource)
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
      p "PAS DE REGISTRATION"
      flash.now[:alert] = resource.errors.full_messages.join(", ")
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

end
