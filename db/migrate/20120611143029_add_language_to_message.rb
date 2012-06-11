class AddLanguageToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :language, :string
  end
end
