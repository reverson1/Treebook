require 'test_helper'

class LeafTest < ActiveSupport::TestCase
 test "that a leaf requires content" do
 	leaf = leaf.new
 	assert !leaf.save
	assert !leaf.errors[:content].empty?
 end

 test "that the content is at leaset two letters long" do
 	leaf = leaf.new
 	leaf.content = "H"
 	assert !leaf.save
	assert !leaf.errors[:content].empty?
 end

 test "that a leaf has a user id" do
 	leaf = leaf.new
 	leaf.content ="Hello"
 	assert !leaf.save
	assert !leaf.errors[:user_id].empty?
 end
end
