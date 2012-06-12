class AddOwnerToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :user_token, :string
  end
end
