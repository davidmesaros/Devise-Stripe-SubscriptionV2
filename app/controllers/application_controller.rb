class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_websites,:logged_in?, :dashboard_params, 
                :dashboard_advertise, :dashboard_data, :dashboard_data_finder, 
                :find_params_for_data_dashboard, :delinquent, :mailer_array, :renew_date,
                :refund_account, :destroy_data

            
          
  # around_filter :set_time_zone
  def _initialize
    dashboard_params if current_user.present?
  end

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end

  def current_websites
     Website.all
  end
  

  def logged_in?# [method] => need to return true or false only
  !!current_user# return current _user => ie  true/false or nil
  end

  def require_user
    if !logged_in?
      flash[:danger] = "you must be logged into perform that action"
      redirect_to root_path
    end
  end


  def dashboard_params # get called welcome#index
    
      current_user.websites.each do |website|
        if website.subscribed == true
            @dashboard_params = Dashboard.find_by(:website_id => website.id) 
            
        end
      end
  
  end

  def find_params_for_data_dashboard # dashbaord#show
    session[:current_dashboard_id] = @dashboard.id # storing the Id data in the sessions
  end

  def dashboard_advertise # google Ad link ( using erb not contoller.)
    @dashboard.website.advertises.each do |advertise|
          return advertise
      end
  end

  def dashboard_data # this methiod is called at Update  => dashbaord contoller

    @@dashboard = @dashboard
    dashboard_data_params
  end

  def dashboard_data_params # this created Data_Dashboard

    @@dashboard
    data_dashboard = DataDashboard.new(:calls => @@dashboard.calls, 
                                          :clicks => @@dashboard.clicks, 
                                          :searches =>@@dashboard.searches,
                                          :cost => @@dashboard.cost, 
                                          :budget => @@dashboard.budget,
                                          :smartphones => @@dashboard.smartphones,
                                          :tablets => @@dashboard.tablets,
                                          :computers => @@dashboard.computers, 
                                          :dashboard_id => @@dashboard.id )
    data_dashboard.save
    
  end

  def total_dashboards
    @data_calls = [] 
    @data_clicks = [] 
    @data_searches = []
    @data_cost = []
    @data_budget = []
    @data_smarthphones = []
    @data_tablets = []
    @data_computers = []
    # @data_dashboards = DataDashboard.where(dashboard_id:18)
    @data_dashboards.each do |data|
      
      
      
      if current_user.admin.blank?
          data_id = data.dashboard_id #<!-- find data_dashbord id -->
          dashboard_obj = Dashboard.find_by(id: data_id) #<!-- find the Dashboard id or website Name -->
        
          web_id = dashboard_obj.website_id # <!-- get the website ID -->
          
          @user = Website.find_by(id:web_id) # <!-- Get the website Name/web address -->
      
          if data.dashboard_id == session[:current_dashboard_id] && current_user.id == @user.user_id
            
            @data_calls << data.calls
            @data_clicks << data.clicks
            @data_searches << data.searches
            @data_cost << data.cost
            @data_budget << data.budget
            @data_smarthphones << data.smartphones
            @data_tablets << data.tablets
            @data_computers << data.computers
          end
      else  
            @data_calls << data.calls
            @data_clicks << data.clicks
            @data_searches << data.searches
            @data_cost << data.cost
            @data_budget << data.budget
            @data_smarthphones << data.smartphones
            @data_tablets << data.tablets
            @data_computers << data.computers
      end
    end 
        
    
    @calls = 0
    @data_calls.each { |a| @calls+=a }
    @calls

    @clicks = 0
    @data_clicks.each { |a| @clicks+=a }
    @clicks

    @searches = 0
    @data_searches.each { |a| @searches +=a }
    @searches

    @cost = 0
    @data_cost.each { |a| @cost +=a }
    @cost

    @budget = 0
    @data_budget.each { |a| @budget +=a }
    @budget

    @smartphones = 0
    @data_smarthphones.each { |a| @smartphones +=a }
    @smartphones

    @tablets = 0
    @data_tablets.each { |a| @tablets +=a }
    @tablets

    @computers = 0
    @data_computers.each { |a| @computers +=a }
    @computers

    
    adverage(@smartphones, @tablets, @computers)


  end

  def dashboard_data_finder
        @data_dashboards.each do |data_dashboard| 
                data_id = data_dashboard.dashboard_id #%> <!-- find data_dashbord id -->
                dashboard_obj = Dashboard.find_by(id: data_id) #%><!-- find the Dashboard id or website Name -->
                web_id = dashboard_obj.website_id # %> <!-- get the website ID -->
                user = Website.find_by(id:web_id) # %> <!-- Get the website Name/web address -->
                if data_dashboard.dashboard_id == dashboard_obj.id && current_user.id == user.user_id
                  @dashboard_obj =  dashboard_obj
                  @web_id = web_id
                  @user = user
                end

        end
  end
  # data_dashboard- Index
  def adverage(smartphones, tablets, computers) 
    @average = []
    total = smartphones + tablets + computers 
    hash = {:smartphones => smartphones,:tablets => tablets, :computers => computers}
    hash.each do | key, value |
                  value  = value /total.to_f  
                  
                  value_floated = value * 100 
                  x = 0
                  if value_floated.to_s[".5"] and x = 0
                    @average << value_floated.floor if !value_floated.nan?
                    x = 1
                  else
                    @average << value_floated.round(0) if !value_floated.nan?
                  end

    end
  end

  def delinquent # get called at for User#index
    @user_payment = Stripe::Customer.all(delinquent:true) 
    @users.each do |user|
      @user_payment.data.each do |data| 
        if data.email == user.email
          user.delinquent = data.delinquent
          user.save
        # else
        #   user.delinquent = false
        #   user.save
        end
      end
    end
  end

  def mailer_array # counts the length of el in dashbaord thus to generate letters to new clients
    #mail_array is called on the dashboard#update controller
    @website = Website.find(@dashboard.website_id)
    d =  @website.date_subscribed + 4.days  
    end_date = @website.date_subscribed + 4.days
      if  Date.today < end_date
        if !d.saturday? || !d.sunday?
          SwiftadsMailer.dashboard_update(@website.user, @website.name).deliver_now #  dashboard update
        end
      elsif Date.today == end_date # last Dashbasboard falls during the week day
        if !d.saturday? || !d.sunday?
          SwiftadsMailer.last_dashboard_update(@website.user, @website.name).deliver_now #  dashboard update
        end
      elsif d.saturday? # Tue Subscribed => last day is Saturday => email out on Monday
        if Date.today == @website.date_subscribed + 6.days 
                SwiftadsMailer.last_dashboard_update(@website.user, @website.name).deliver_now #  dashboard update
        end 
      elsif d.sunday? #wed Subscribed => last day is Sun => email out on Monday
        if Date.today == @website.date_subscribed + 5.days 
                SwiftadsMailer.last_dashboard_update(@website.user, @website.name).deliver_now #  dashboard update
        end 
      end  
            
  end

  # reset the start date for subscription, issues and invoice..
  # renew_date gets called on the Website#index controller
  def renew_date 
    @websites.each do |web|
      if web.end_date.present?
        end_date = web.end_date + 1.day
        start_date = web.date_subscribed
        
          if end_date == Date.today
            web.date_subscribed = Date.today 
            web.end_date = Date.today + 1.month
            web.save
            SwiftadsMailer.swiftads_invoice(web.user, web.name, web.stripeid).deliver_now
          end
        end
      end
  end
  # after 1 month any balance left over Google Ad, is refunded back and subscription start again
  def refund_account(balance) #=> dashboard#show
     
    @website = Website.find(@dashboard.website_id)
    if balance > 5 && Date.today == @website.end_date && @website.days_left == nil
      SwiftadsMailer.swiftads_invoice_refund(@website.user, @website.name, @website.stripeid, balance).deliver_now
      @website.days_left = 0
      @website.save
    elsif @website.days_left == 0 && @website.date_subscribed + 1.day == Date.today
      @website.days_left = ''
      @website.save
    elsif @website.subscribed == false && @website.stripeid.present? # calculate refund if cancelled subscription
      days_in_monthly = (@website.end_date.to_date - @website.date_subscribed.to_date)
      days_left =  ( @website.end_date.to_date - Date.today.to_date )
      cancel_balance = days_left.to_i / days_in_monthly.to_i * 75
      total_balance = balance + cancel_balance
      SwiftadsMailer.swiftads_invoice_cancel_refund(@website.user, @website.name, @website.stripeid, total_balance).deliver_now
      @website.stripeid
    end

    
  end

  def destroy_data
    list_users = []
      @dashboards.each do |dash|
        user =  Website.find(dash.website_id)
          if user.end_date == Date.today + 1.day
          list_users << user if user.end_date == Date.today
          end
      end
    user_dashboards = []
      list_users.each do |user|
      user_dashboards << user.dashboards
    end

    
      user_dashboards.each do |data_dash|
        data_dash.each do |data|
          data.data_dashboards.destroy_all
        end
    end
    
  end



end
