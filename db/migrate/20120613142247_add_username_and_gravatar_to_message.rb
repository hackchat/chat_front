class AddUsernameAndGravatarToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :avatar, :string
    add_column :messages, :name, :string
  end
end
