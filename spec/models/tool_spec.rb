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

require 'spec_helper'

describe Tool do
	let(:cocktail) { FactoryGirl.create(:cocktail) }
	before do
		@tool = cocktail.tools.build(tool: "straws")
	end

	subject { @tool }

	it { should be_valid }

	it { should respond_to(:cocktail_id) }
	it { should respond_to(:tool) }
	it { should respond_to(:cocktail) }
  	its(:cocktail) { should == cocktail }

	describe "when cocktail_id is not present" do
		before { @tool.cocktail_id = nil }
		it { should_not be_valid }
	end

	describe "with blank tool" do
		before { @tool.tool = ' ' }
		it { should_not be_valid }
	end

	describe "accessible attributes" do

    	it "should not allow access to cocktail_id" do
      		expect do
        		Tool.new(cocktail_id: cocktail.id)
      		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    	end    
  	end

end
