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

require 'spec_helper'

describe Cocktail do
	before { @cocktail = Cocktail.new(name: "Example Cocktail", family: "Long", makes: 2,
									  glass: "tall", chilled: "false") }

	subject { @cocktail }

	it { should respond_to(:name) }
	it { should respond_to(:family) }
	it { should respond_to(:makes) }
	it { should respond_to(:glass) }
	it { should respond_to(:chilled) }

	it { should be_valid }

	describe "when name is not present" do
		before { @cocktail.name=" " }
		it { should_not be_valid }
	end

	describe "when family is not present" do
		before { @cocktail.family=" " }
		it { should_not be_valid }
	end

	describe "when makes is not present" do
		before { @cocktail.makes=" " }
		it { should_not be_valid }
	end

	describe "when glass is not present" do
		before { @cocktail.glass=" " }
		it { should_not be_valid }
	end

	describe "when cocktail name is already taken" do
		before do
			cocktail_with_same_name = @cocktail.dup
			cocktail_with_same_name.name = @cocktail.name.upcase
			cocktail_with_same_name.save
		end

		it { should_not be_valid }
	end
  
end
