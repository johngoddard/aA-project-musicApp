class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def activation_email(user)
    @url = "http://localhost:3000/users/#{user.id}/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: 'Welcome to Music App')
  end
end
