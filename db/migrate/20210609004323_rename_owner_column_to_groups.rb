class RenameOwnerColumnToGroups < ActiveRecord::Migration[5.2]
  def change
    rename_column :groups, :owner, :owner_id
  end
end
