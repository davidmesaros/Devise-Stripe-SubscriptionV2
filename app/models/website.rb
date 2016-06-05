class Website < ActiveRecord::Base
  belongs_to :user
  has_many :advertises , dependent: :destroy
  has_one :subscriber
  has_many :dashboards, dependent: :destroy
  has_many :cancel_plans 
end
