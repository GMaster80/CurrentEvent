class AddMessageToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :message, :text
  end
end
