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
	it { should respond_to(:tools) }
	it { should respond_to(:ingredients) }
	it { should respond_to(:directions) }
	it { should respond_to(:votes) }

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

	describe "tools associations" do

	    before { @cocktail.save }
	    let!(:first_tool) { FactoryGirl.create(:tool, cocktail: @cocktail) }
	    let!(:second_tool) { FactoryGirl.create(:tool, cocktail: @cocktail) }

	    it "should have the right tools" do
	      @cocktail.tools.should == [first_tool, second_tool]
	    end

	    it "should destroy associated tools" do
	    	tools = @cocktail.tools
	      	@cocktail.destroy
	      	tools.each do |tool|
	        	Tool.find_by_id(tool.id).should be_nil
	    	end
	    end
    end

	describe "ingredients associations" do

	    before { @cocktail.save }
	    let!(:first_ingredient) { FactoryGirl.create(:ingredient, cocktail: @cocktail) }
	    let!(:second_ingredient) { FactoryGirl.create(:ingredient, cocktail: @cocktail) }

	    it "should have the right ingredients" do
	      @cocktail.ingredients.should == [first_ingredient, second_ingredient]
	    end

	    it "should destroy associated ingredients" do
	    	ingredients = @cocktail.ingredients
	      	@cocktail.destroy
	      	ingredients.each do |ingredient|
	        	ingredient.find_by_id(ingredient.id).should be_nil
	    	end
	    end
    end

    describe "direction associations" do

	    before { @cocktail.save }
	    let!(:first_direction) { FactoryGirl.create(:direction, cocktail: @cocktail) }
	    let!(:second_direction) { FactoryGirl.create(:direction, cocktail: @cocktail) }

	    it "should have the right directions" do
	      @cocktail.directions.should == [first_direction, second_direction]
	    end

	    it "should destroy associated directions" do
	    	directions = @cocktail.directions
	      	@cocktail.destroy
	      	directions.each do |direction|
	        	direction.find_by_id(direction.id).should be_nil
	    	end
	    end
    end 
  
end
