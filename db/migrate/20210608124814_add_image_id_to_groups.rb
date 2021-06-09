class AddImageIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :Image_id, :string
  end
end
