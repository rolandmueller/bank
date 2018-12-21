class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :description
      t.float :balance_after_transaction
      t.integer :account_id

      t.timestamps
    end
  end
end
