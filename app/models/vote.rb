# == Schema Information
#
# Table name: votes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  cocktail_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Vote < ActiveRecord::Base
	attr_accessible :cocktail_id

	belongs_to :user
	belongs_to :cocktail

	validates :user_id, presence: true
	validates :cocktail_id, presence: true
end
