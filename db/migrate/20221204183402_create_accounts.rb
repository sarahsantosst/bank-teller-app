class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :code
      t.decimal :balance

      t.timestamps
    end
  end
end
