class Department < ActiveRecord::Base
  has_many :tickets
end
