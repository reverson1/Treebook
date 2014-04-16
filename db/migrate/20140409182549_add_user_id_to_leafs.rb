class AddUserIdToLeafs < ActiveRecord::Migration
  def change
  	add_column :leafs, :user_id, :integer
  	add_index :leafs, :user_id
  	remove_column :leafs, :name
  end
end
