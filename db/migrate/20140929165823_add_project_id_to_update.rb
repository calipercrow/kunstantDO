class AddProjectIdToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :project_id, :integer
    add_index :project_id
  end
end
