require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "cocktail show page" do
		let(:cocktail) { FactoryGirl.create(:cocktail) }
		before { visit cocktail_path(cocktail) }

		it { should have_selector('h1',    text: cocktail.name) }
		it { should have_selector('title', text: cocktail.name) }
	end
	
end
