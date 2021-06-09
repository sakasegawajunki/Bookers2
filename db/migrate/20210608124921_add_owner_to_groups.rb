class AddOwnerToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :Owner_id, :integer
  end
end
