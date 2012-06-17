class AddStatusToRoomie < ActiveRecord::Migration
  def change
    add_column :roomies, :status, :string
  end
end
