class Vote < ActiveRecord::Base
	attr_accessible :cocktail_id

	belongs_to :user
	belongs_to :cocktail

	validates :user_id, presence: true
	validates :cocktail_id, presence: true
end
