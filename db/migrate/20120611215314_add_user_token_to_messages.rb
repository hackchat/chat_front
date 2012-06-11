class AddUserTokenToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :user_token, :string
  end
end
