class AddDepartmentIdToReplies < ActiveRecord::Migration
  def change
    add_reference :replies, :department, index: true
  end
end
