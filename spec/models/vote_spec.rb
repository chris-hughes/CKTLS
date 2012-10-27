require 'spec_helper'

describe Vote do

	let(:user) 		{ FactoryGirl.create(:user) }
	let(:cocktail)	{ FactoryGirl.create(:cocktail) }
	let(:vote)		{ user.votes.build(cocktail_id: cocktail.id) }

	subject { vote }

	it { should be_valid }

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				Vote.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "join tests" do
		it { should respond_to(:user) }
		it { should respond_to(:cocktail) }
		its(:user) { should == user }
		its(:cocktail) {should == cocktail }
	end

	describe "when user id is not present" do
	    before { vote.user_id = nil }
	    it { should_not be_valid }
    end

    describe "when cocktail id is not present" do
	    before { vote.cocktail_id = nil }
	    it { should_not be_valid }
    end

end
