class AddAvatarToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :photo, :string
    add_column :users, :coverimage, :string
    add_column :users, :fullname, :string
    add_column :users, :username, :string
  end
end
