# == Schema Information
#
# Table name: directions
#
#  id          :integer          not null, primary key
#  cocktail_id :integer
#  direction   :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Direction < ActiveRecord::Base
	attr_accessible :direction
	belongs_to :cocktail

	validates :cocktail_id, presence: true
	validates :direction, presence: true
end
