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
	attr_accessible :name, :family, :makes, :glass, :chilled
	has_many :tools, dependent: :destroy

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :family, presence: true, length: { maximum: 50 }
	validates :makes, presence: true
	validates :glass, presence: true

	before_save { |cocktail| cocktail.name = name.downcase }

end
