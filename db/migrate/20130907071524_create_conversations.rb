class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
    	t.integer :user_id
    	t.integer :second_user_id

      t.timestamps
    end
  end
end
