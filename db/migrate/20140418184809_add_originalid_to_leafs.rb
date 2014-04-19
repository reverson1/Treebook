class AddOriginalidToLeafs < ActiveRecord::Migration
  def change
  	add_column :leafs, :original_id, :integer
    add_index :leafs, :original_id
  end
end
