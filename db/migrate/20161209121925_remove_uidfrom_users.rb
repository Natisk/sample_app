class RemoveUidfromUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook_uid, :string
    add_column :users, :twitter_uid, :string
    remove_column :users, :uid, :string
  end
end
