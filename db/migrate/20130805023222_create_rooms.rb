class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :room_id
      t.string :name
      t.string :topic
      t.boolean :is_private
      t.boolean :is_archived

      t.timestamps
    end
  end
end
