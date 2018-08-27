class HelloWorldMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.hello_world_mailer.hello.subject
  #

  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: "Registation done")
  end
end
