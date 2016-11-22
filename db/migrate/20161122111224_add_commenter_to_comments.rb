class AddCommenterToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commenter, :integer
    remove_column :comments, :commenter_id
  end
end
