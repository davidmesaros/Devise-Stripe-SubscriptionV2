class DataDashboard < ActiveRecord::Base
  belongs_to :dashboard



  def self.search(search)
    if search
      search = search.to_i
      self.where("dashboard_id = ?", "%#{search}%")
    else
      self.all
    end
  end

  
end
