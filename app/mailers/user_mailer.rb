class UserMailer < ActionMailer::Base
  default from: "noreply@inventoryapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset", from: "noreply@inventorytracker.herokuapp.com"
  end
end
