class AddOwnerRefToReplies < ActiveRecord::Migration
  def change
    add_reference :replies, :owner, index: true
  end
end
