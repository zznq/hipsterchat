class AddLastActiveColumnToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :last_active, :datetime
  end
end
