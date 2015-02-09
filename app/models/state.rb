class State < ActiveRecord::Base
  has_many :tickets, inverse_of: :state, dependent: :destroy
  has_many :replies, inverse_of: :state, dependent: :destroy
  validates :name, presence: true
  before_destroy :check
private

  def check
    if tickets.any? or replies.any?
      errors[:base] << "cannot delete state"
      return false
    end
  end
end
