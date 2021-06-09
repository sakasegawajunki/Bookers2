class RenameImageIdColumnToGroups < ActiveRecord::Migration[5.2]
  def change
     rename_column :groups, :Image_id, :image_id
  end
end
