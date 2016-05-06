class Website < ActiveRecord::Base
  belongs_to :user
  has_many :advertises , dependent: :destroy
  has_one :subscriber
end