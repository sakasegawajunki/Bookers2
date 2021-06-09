class RemoveIntroductionFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :name, :text
  end
end
