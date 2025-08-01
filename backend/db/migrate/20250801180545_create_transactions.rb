class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.text :account_number
      t.text :account_holder
      t.float :amount
      t.string :status

      t.timestamps
    end
  end
end
