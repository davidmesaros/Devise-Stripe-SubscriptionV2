class SubscribersController < ApplicationController
  before_filter :authenticate_user!


  def new
    @website_id = params[:website]
    @@website = Website.find_by(:id => @website_id)

  end

  def update
    token = params[:stripeToken] 
    customer = Stripe::Customer.create(
        card: token,
        plan: 1001,
        email: current_user.email
        )

    current_user.subscribed = true
    
    # I create my column here for website tabel
    @@website.subscribed = true
    @@website.save  
    current_user.stripeid = customer.id
    current_user.save
    flash[:notice] = "Successfully Entered"

    redirect_to websites_path

  end
end
