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

	validates_presence_of :cocktail
	validates :direction, presence: true
end
