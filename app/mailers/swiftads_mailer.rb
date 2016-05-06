class SwiftadsMailer < ApplicationMailer
  def swiftads_email(user)
    @user = user
    # byebug
    mail(to: @user.email, bcc: 'mesarosda@gmail.com', subject: 'Swiftads Email Notification')
  end
end
