class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :companions, default: 0
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
