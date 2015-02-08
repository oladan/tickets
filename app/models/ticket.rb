class Ticket < ActiveRecord::Base
  has_many :replies
  belongs_to :department
  belongs_to :state
  belongs_to :owner
  validates :client_name, :client_email, :subject, :body, :department, presence: true

  def count_replies
    Reply.where(:ticket_id => self.id).count
  end
end
