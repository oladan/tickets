class AddStateIdToReplies < ActiveRecord::Migration
  def change
    add_reference :replies, :state, index: true
  end
end
