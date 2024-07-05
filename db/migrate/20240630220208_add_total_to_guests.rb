class AddTotalToGuests < ActiveRecord::Migration[7.1]
  def change
    add_column :guests, :total, :integer, default: 0
  end
end
