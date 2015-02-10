class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Ticket < ActiveRecord::Base
  has_many :replies
  belongs_to :department
  belongs_to :state
  belongs_to :owner
  validates :client_name, :client_email, :subject, :body, :department, presence: true
  validates_uniqueness_of :uniq_reference
  validates :client_email, email: true
  extend FriendlyId
  friendly_id :uniq_reference
  
  scope :filter_department, -> (department_id) { where department_id: department_id }
  scope :filter_state, -> (state_id) { where state_id: state_id }
  scope :filter_subject, -> (subject) { where("subject like ? or body like ? or uniq_reference like ?", 
                                              "%#{subject}%", "%#{subject}%", "%#{subject}%")}
  before_validation(on: :create) do
    self.uniq_reference = uniq_ref
  end

  private
    def char_gen
      ('A'..'Z').to_a.shuffle[0, 3].join
    end

    def hex_gen
      SecureRandom.hex(1).upcase
    end

    def uniq_ref
      char_gen + '-' + hex_gen + '-' + char_gen + '-' + hex_gen + '-' + char_gen
    end
end