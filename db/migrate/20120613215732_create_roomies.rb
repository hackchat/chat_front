class CreateRoomies < ActiveRecord::Migration
  def change
    create_table :roomies do |t|
      t.string :user_token
      t.integer :room_id
      t.timestamps
    end
  end
end
