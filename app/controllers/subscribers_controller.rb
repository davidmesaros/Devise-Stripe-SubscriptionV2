class SubscribersController < ApplicationController
  before_filter :authenticate_user!


  def new
    @website_id = params[:website]
    @@website = Website.find_by(:id => @website_id)

  end

  def update

      token = params[:stripeToken] 
      begin
        customer = Stripe::Customer.create(
            card: token,
            plan: 33999,
            email: current_user.email
            )

        
        
        @@website.stripeid = customer.id
        @@website.end_date =  Date.today + 1.month - 1.day
        @@website.subscribed = true
        @@website.date_subscribed = Date.today
        @@website.save  

        SwiftadsMailer.swiftads_invoice(@@website.user, @@website.name, @@website.stripeid).deliver_now
        # SwiftadsMailer.trial_period(@@website.user, @@website.name, @@website.stripeid).deliver_now
        
        SwiftadsMailer.new_subscription(@@website.user, @@website.name, @@website.stripeid).deliver_now

        

        flash[:notice] = "Your Payment Details was successful, an email will be sent out to you shortly confirming your transaction"

        rescue Stripe::CardError => e
        flash[:danger] = 'Your Credit Card was decline. Please check your Credit Card Details and try again. If it Fails one more time
        you might need to contact your Bank for more information'
        rescue => e
        # Some other error; display an error message.
        flash[:notice] = 'Some error occurred.'
      end

      
      redirect_to websites_path

    end


end
