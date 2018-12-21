class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :number
      t.float :balance
      t.integer :customer_id

      t.timestamps
    end
  end
end
