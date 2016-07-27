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
    mail(to: @user.email, bcc: 'david.mesaros@swiftads.com.au', subject: 'Swiftads Cancellation Email Notification')
  end 

  def new_subscription(user, website, stripeid)
    @user = user
    @website = website
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'david.mesaros@swiftads.com.au', subject: 'Confirmation of Payment - Swiftads')
    
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
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Tax Invoice - Swiftads')
  end

  def dashboard_update(user, website)
    @user = user
    @website = website
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Swiftads Dashboard Update')
  end

  def last_dashboard_update(user, website)
    @user = user
    @website = website
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Swiftads Dashboard Update')
  end

  def swiftads_invoice_refund(user, website, stripeid, balance)
    @user = user
    @website = website
    @stripeid = stripeid
    @balance = balance
    mail(to: @user.email, bcc: 'david.mesaros@swiftads.com.au', subject: 'Tax Invoice - Refund - Swiftads')
  end

   def swiftads_invoice_cancel_refund(user, website, stripeid, balance)
    @user = user
    @website = website
    @stripeid = stripeid
    @balance = balance
    mail(to: @user.email, bcc: 'david.mesaros@swiftads.com.au', subject: 'Tax Invoice - Refund - Swiftads')
  end

  def trial_period(user, website, stripeid)
    @user = user
    @website = website
    @stripeid = stripeid
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Trail Period - Swiftads')
  end

  def dashboard_update_stats(user, website, calls, clicks, searches, cost, balance, smartphones, tablets, computers )
    @user = user
    @website = website
    @calls = calls
    @clicks = clicks
    @searches = searches
    @cost = cost
    @balance = balance
    @smartphones = smartphones
    @tablets = tablets
    @computers = computers
    mail(to: @user.email, bcc: 'swiftads.au@gmail.com', subject: 'Daily Dashboard Update - Swiftads')
  end
end
