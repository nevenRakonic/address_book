class RegistrationsController  < Devise::RegistrationsController
  # We overwrite the default Devise method to send a welcome e-mail
  def create
    super
    UserMailer.welcome_email(@user).deliver if @user.persisted?
  end
end
