class State < ActiveRecord::Base
  has_many :tickets
  has_many :replies
end
