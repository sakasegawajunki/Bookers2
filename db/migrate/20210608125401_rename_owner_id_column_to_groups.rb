class RenameOwnerIdColumnToGroups < ActiveRecord::Migration[5.2]
  def change
    rename_column :groups, :Owner_id, :owner
  end
end
