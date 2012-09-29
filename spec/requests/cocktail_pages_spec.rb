require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "cocktail show page" do
		let(:cocktail) { FactoryGirl.create(:cocktail) }
		before { visit cocktail_path(cocktail) }

		it { should have_selector('h1',    text: cocktail.name.titleize) }
		it { should have_selector('title', text: cocktail.name.titleize) }
	end

	describe "New cocktail Page" do
		before { visit new_cocktail_path }
		it { should have_selector('h1', text:'Create Your Cocktail') }
		it { should have_selector('title', text: 'CKTLS | Create') }
	end

	describe "Create new cocktail" do
		before { visit new_cocktail_path }

		let(:submit) { "Create my cocktail" }

		describe "with invalid information" do
			it "should not create a new cocktail" do
				expect { click_button submit }.not_to change(Cocktail, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",			with: "Example cocktail"
				select "Fruity",		from: "Family"
				fill_in "Makes",		with: 2
				select "Martini glass", from: "Glass"
				select "No",			from: "Chilled"
			end

			it 'should create a cocktail' do
				expect { click_button submit }.to change(Cocktail, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				
				it { should have_selector('h1', text: "Example Cocktail") }
			end
		end
	end

end
