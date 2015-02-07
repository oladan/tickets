class Ticket < ActiveRecord::Base
  has_many :replies
  belongs_to :department
  belongs_to :state
  belongs_to :owner
end
