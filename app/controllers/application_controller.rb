class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_websites, :created_ad, :logged_in?, :dashboard_params, 
                :dashboard_advertise, :dashboard_data
          
  # around_filter :set_time_zone
  

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end

  def current_websites
     Website.all
  end

  def created_ad
      current_user.websites.each do |website|
          return website
      end
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


  def dashboard_params
    current_user.websites.each do |website|
      if website.subscribed == true
          params = Dashboard.find_by(:website_id => website.id)
          return params
      end
    end
  end

  def dashboard_advertise
    @dashboard.website.advertises.each do |advertise|
          return advertise
      end
  end

  def dashboard_data
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
    @data_dashboards.each do |data|
        data_id = data.dashboard_id #<!-- find data_dashbord id -->
        dashboard_obj = Dashboard.find_by(id: data_id) #<!-- find the Dashboard id or website Name -->
        web_id = dashboard_obj.website_id # <!-- get the website ID -->
        @user = Website.find_by(id:web_id) # <!-- Get the website Name/web address -->
        unless current_user.admin.blank?
          if data.dashboard_id == dashboard_obj.id && current_user.id == web_id
        end
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

  end


end
