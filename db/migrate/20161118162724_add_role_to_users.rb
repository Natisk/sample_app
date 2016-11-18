class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: 'member'
    remove_column :users, :admin
  end
end
