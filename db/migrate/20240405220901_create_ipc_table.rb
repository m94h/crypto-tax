class CreateIpcTable < ActiveRecord::Migration[7.0]
  def change
    create_table :ipcs do |t|
      t.date :date, null: false
      t.decimal :value, null: false
    end
  end
end
