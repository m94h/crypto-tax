class CreateCryptoOperationTable < ActiveRecord::Migration[7.0]
  def change
    create_table :crypto_operations do |t|
      t.string :operation_type, null: false, index: true
      t.decimal :shares, null: false
      t.datetime :timestamp, null: false
      t.monetize :capital, amount: { null: false, default: nil }, currency: { null: false, default: nil }
      t.references :crypto_currency, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
