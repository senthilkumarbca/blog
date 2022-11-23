class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sign_up_mail.subject
  #
  def sign_up_mail(object)
    @greeting = "Hi"
    @object = object

    mail to: "senthilthoondi@gmail.com", subject: "sentil Blog#{object.class}"
  end
end
