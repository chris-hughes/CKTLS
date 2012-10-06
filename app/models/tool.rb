# == Schema Information
#
# Table name: tools
#
#  id          :integer          not null, primary key
#  cocktail_id :integer
#  tool        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tool < ActiveRecord::Base
	attr_accessible :tool
	belongs_to :cocktail

	validates_presence_of :cocktail
	validates :tool, presence: true
end
