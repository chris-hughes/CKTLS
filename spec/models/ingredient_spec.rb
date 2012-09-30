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

require 'spec_helper'

describe Ingredient do
	let(:cocktail) { FactoryGirl.create(:cocktail) }
	before do
		@ingredient = cocktail.ingredients.build(ingredient: "vodka", measure: 2, unit: "shots", decoration: "false" )
	end

	subject { @ingredient }

	it { should be_valid }

	it { should respond_to(:cocktail_id) }
	it { should respond_to(:ingredient) }
	it { should respond_to(:measure) }
	it { should respond_to(:unit) }
	it { should respond_to(:decoration) }
	it { should respond_to(:cocktail) }
  	its(:cocktail) { should == cocktail }

	describe "when cocktail_id is not present" do
		before { @ingredient.cocktail_id = nil }
		it { should_not be_valid }
	end

	describe "with blank ingredient" do
		before { @ingredient.ingredient = ' ' }
		it { should_not be_valid }
	end

	describe "accessible attributes" do

    	it "should not allow access to cocktail_id" do
      		expect do
        		Ingredient.new(cocktail_id: cocktail.id)
      		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    	end    
  	end
end
