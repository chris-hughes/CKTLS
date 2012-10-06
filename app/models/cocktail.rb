# == Schema Information
#
# Table name: cocktails
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  family     :string(255)
#  makes      :integer
#  glass      :string(255)
#  chilled    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cocktail < ActiveRecord::Base
	attr_accessible :name, :family, :makes, :glass, :chilled, 
					:tools_attributes, :ingredients_attributes, :directions_attributes

	has_many :tools, :inverse_of => :cocktail, dependent: :destroy
	has_many :ingredients, :inverse_of => :cocktail, dependent: :destroy
	has_many :directions, :inverse_of => :cocktail, dependent: :destroy

	accepts_nested_attributes_for :tools, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	accepts_nested_attributes_for :directions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :family, presence: true, length: { maximum: 50 }
	validates :makes, presence: true
	validates :glass, presence: true

	before_save { |cocktail| cocktail.name = name.downcase }

end
