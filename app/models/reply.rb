class Reply < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :owner
end
