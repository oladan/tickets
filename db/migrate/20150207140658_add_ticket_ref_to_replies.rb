class AddTicketRefToReplies < ActiveRecord::Migration
  def change
    add_reference :replies, :ticket, index: true
  end
end
