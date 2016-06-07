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
            plan: 1001,
            email: current_user.email
            )

        
        
        @@website.stripeid = customer.id
        @@website.end_date =  Date.today + 1.month
        @@website.subscribed = true
        @@website.date_subscribed = Date.today
        @@website.save  
        
        SwiftadsMailer.new_subscription(@@website.user, @@website.name, @@website.stripeid).deliver_now


        

        flash[:notice] = "Successfully Entered , an email will be sent shortly confirming your payment"

        rescue Stripe::CardError => e
        flash[:danger] = 'Your Credit Card was decline. Please check your Credit Card Details and try again. If it Fails one more time
        you might need to contact your Bank for more information'
        rescue => e
        # Some other error; display an error message.
        flash[:notice] = 'Some error occurred.'
      end

      SwiftadsMailer.swiftads_invoice(@@website.user, @@website.name, @@website.stripeid).deliver_now
      redirect_to websites_path

    end


end
