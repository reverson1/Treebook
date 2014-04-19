class Leaf < ActiveRecord::Base
	belongs_to :user 
	attr_accessible :content, :user_id

	validates :content, presence: true,
						length: {minimum: 2}

	validates :user_id, presence: true
end
