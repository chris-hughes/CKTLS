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

require 'spec_helper'

describe Direction do
	let(:cocktail) { FactoryGirl.create(:cocktail) }
	before do
		@direction = cocktail.directions.build(direction: "Muddle everything")
	end

	subject { @direction }

	it { should be_valid }

	it { should respond_to(:cocktail_id) }
	it { should respond_to(:direction) }
	it { should respond_to(:cocktail) }
  	its(:cocktail) { should == cocktail }

	describe "when cocktail_id is not present" do
		before { @direction.cocktail_id = nil }
		it { should_not be_valid }
	end

	describe "with blank tool" do
		before { @direction.direction = ' ' }
		it { should_not be_valid }
	end

	describe "accessible attributes" do

    	it "should not allow access to cocktail_id" do
      		expect do
        		Direction.new(cocktail_id: cocktail.id)
      		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    	end    
  	end
end
