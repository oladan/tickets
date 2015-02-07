class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :client_name
      t.string :client_email
      t.string :subject
      t.text :body
      t.string :uniq_reference

      t.timestamps
    end
  end
end
