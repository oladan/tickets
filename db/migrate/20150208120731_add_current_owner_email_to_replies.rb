class AddCurrentOwnerEmailToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :current_owner_email, :string
  end
end
