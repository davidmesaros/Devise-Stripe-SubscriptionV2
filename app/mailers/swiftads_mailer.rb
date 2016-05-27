class SwiftadsMailer < ApplicationMailer
  def swiftads_email(user, website)
    @user = user
    @website = website
    mail(to: @user.email, bcc: 'mesarosda@gmail.com', subject: 'Swiftads Email Notification')
  end

  def swiftads_email_update(user, website, product, product1, product2)
    @user = user
    @website = website
    @product = product
    @product1 = product1
    @product2 = product2
    mail(to: @user.email, bcc: 'mesarosda@gmail.com', subject: 'Swiftads Email Notification')
  end
end
