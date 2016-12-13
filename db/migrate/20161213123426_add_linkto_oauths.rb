class AddLinktoOauths < ActiveRecord::Migration[5.0]
  def change
    add_column :oauths, :link, :string
  end
end
