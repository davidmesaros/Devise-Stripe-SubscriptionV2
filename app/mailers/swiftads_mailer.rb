class SwiftadsMailer < ApplicationMailer
  def swiftads_email(user, website)
    @user = user
    @website = website
    # byebug
    mail(to: @user.email, bcc: 'mesarosda@gmail.com', subject: 'Swiftads Email Notification')
  end
end
