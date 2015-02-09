class Ticket < ActiveRecord::Base
  has_many :replies
  belongs_to :department
  belongs_to :state
  belongs_to :owner
  validates :client_name, :client_email, :subject, :body, :department, presence: true
  validates_uniqueness_of :uniq_reference
  
  scope :filter_department, -> (department_id) { where department_id: department_id }
  scope :filter_state, -> (state_id) { where state_id: state_id }
  scope :filter_subject, -> (subject) { where("subject like ? or body like ? or uniq_reference like ?", 
                                              "%#{subject}%", "%#{subject}%", "%#{subject}%")}
  def count_replies
    Reply.where(:ticket_id => self.id).count
  end
end
