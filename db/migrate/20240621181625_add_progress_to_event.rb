class AddProgressToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :progress, :integer, default: 0
  end
end
