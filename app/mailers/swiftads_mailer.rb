class SwiftadsMailer < ApplicationMailer
  def swiftads_email(user, website)
    @user = user
    @website = website
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Swiftads Email Notification')
  end

  def swiftads_email_update(user, website, product, product1, product2)
    @user = user
    @website = website
    @product = product
    @product1 = product1
    @product2 = product2
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Swiftads Email Notification')
  end

  def cancel_subscription(user, website, stripeid)
    @user = user
    @website = website
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Swiftads Cancellation Email Notification')
  end 

  def new_subscription(user, website, stripeid)
    @user = user
    @website = website
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Welcome to Swiftads')
    
  end

  def swiftads_advertise_created(user, website, description)
    @user = user
    @website = website
    @advertise = description
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Google Ad for your Website is Now Ready')
    
  end

  def swiftads_invoice(user, website, stripeid)
    @user = user
    @website = website
    @@stripeid = stripeid
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Tax Invoice - Swiftads')
  end
end
