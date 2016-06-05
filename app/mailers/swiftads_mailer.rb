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

  def cancel_subscription(user, website, stripeid)
    @user = user
    @website = website
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'mesarosda@gmail.com', subject: 'Swiftads Cancellation Email Notification')
  end 

  def new_subscription(user, website, stripeid)
    @user = user
    @website = website
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'mesarosda@gmail.com', subject: 'Welcome to Swiftads')
    
  end
end
