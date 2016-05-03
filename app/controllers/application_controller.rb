class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_website, :created_ad
  around_filter :set_time_zone

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end

  def current_website
     Website.all
  end

  def created_ad
   
      current_user.websites.each do |website|
          return website
      end
  
  end

  
  

end
