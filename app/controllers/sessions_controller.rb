class SessionsController < Devise::SessionsController
  def create
    @user = User.find_by(email:params["user"]["email"])
      if @user&.valid_password?(params["user"]["password"])
        sign_in(:user, @user)
        redirect_to root_path
      else
        flash[:alert] = "Invalid Email or Password"
        redirect_back(fallback_location: root_path)
      end
    end
end
