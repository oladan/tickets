class Reply < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :owner
  belongs_to :department
  belongs_to :state
  validates :body, presence: true
end
