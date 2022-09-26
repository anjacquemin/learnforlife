class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = root_url
    p "SENDING EMAIL"
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
