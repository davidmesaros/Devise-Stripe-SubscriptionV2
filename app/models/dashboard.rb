class Dashboard < ActiveRecord::Base
  belongs_to :website
  has_many :data_dashboards, dependent: :destroy
end
