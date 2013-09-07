class AddCurrenturlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_url, :string
  end
end
