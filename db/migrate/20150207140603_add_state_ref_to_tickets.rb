class AddStateRefToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :state, index: true
  end
end
