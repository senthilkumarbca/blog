# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/sign_up_mail
  def sign_up_mail
    UserMailer.sign_up_mail
  end

end
