# == Schema Information
#
# Table name: ingredients
#
#  id          :integer          not null, primary key
#  cocktail_id :integer
#  ingredient  :string(255)
#  measure     :integer
#  unit        :string(255)
#  decoration  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ingredient < ActiveRecord::Base
	attr_accessible :decoration, :ingredient, :measure, :unit
  	belongs_to :cocktail

	validates_presence_of :cocktail
	# validates :decoration, presence: true
	validates :ingredient, presence: true
	validates :measure, presence: true
	validates :unit, presence: true
end
