# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/user_thanks_mail
  def user_thanks_mail
    UserMailer.with(user: User.first).user_thanks_mail
  end

end
