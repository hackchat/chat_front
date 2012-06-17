class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :url
      t.integer :room_id
      t.string :user_token

      t.timestamps
    end
  end
end
