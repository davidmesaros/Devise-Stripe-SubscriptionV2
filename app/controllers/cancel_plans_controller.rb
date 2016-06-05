class CancelPlansController < ApplicationController
  def show
   @@user_plans =  params[:id]
  end
  def index
    if current_user.admin.blank?
      @website = Website.find(@@user_plans) # find params of the cancel_plan website
      @website.subscribed = false # toggle to false status
       @website.save
      @customer = Stripe::Customer.retrieve(
            @website.stripeid
            ) 
     
     SwiftadsMailer.cancel_subscription(@website.user, @website.name, @website.stripeid).deliver_now

   else 
   # ADMIN can only cancel --> Ensure refund is activate on Stripe Dashboard
   # Notes ----------------------------------------------->

       #  When cancel email come through - 
       #  In Stripe dashboard.
       # -  Must check to refund the difference before cancel very IMPORTANT 

      @website = Website.find(@@user_plans) # find params of the cancel_plan website
      
       if @website.stripeid.present?
          customer = Stripe::Customer.retrieve(
            @website.stripeid
            ) 
          customer.delete # cancel the sunscribtion
        @website.stripeid = nil
        @website.subscribed = false # toggle to false status
        @website.end_date = ''
        @website.date_subscribed = ''
        @website.save 
     
      end
    end
  end
  

      

end