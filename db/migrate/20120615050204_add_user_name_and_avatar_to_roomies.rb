class AddUserNameAndAvatarToRoomies < ActiveRecord::Migration
  def change
    add_column :roomies, :name, :string
    add_column :roomies, :avatar, :string
  end
end
