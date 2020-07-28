# "localhost:3000/rails/mailers/devise/mailer/#{action}"
class Devise::MailerPreview < ActionMailer::Preview
  include Devise::Mailers::Helpers

  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.last, {})
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, {})
  end

  # TODO
  # def password_change
  #   Devise::Mailer.password_change(User.first, {})
  # end
end
