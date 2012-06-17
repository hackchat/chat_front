class AddFileNameToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :file_name, :string
  end
end
