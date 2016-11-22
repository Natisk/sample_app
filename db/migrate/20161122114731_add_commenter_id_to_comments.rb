class AddCommenterIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commenter_id, :integer
    remove_column :comments, :commenter
  end
end
