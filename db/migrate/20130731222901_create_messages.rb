class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.datetime :date
      t.integer :from_id
      t.text :message

      t.timestamps
    end
  end
end
