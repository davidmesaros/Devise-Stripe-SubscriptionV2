class Website < ActiveRecord::Base
  belongs_to :user
  has_many :advertises
  has_one :subscriber
end
