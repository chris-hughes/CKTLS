require 'spec_helper'

describe "CocktailPages" do

	subject { page }

	describe "cocktail show page" do
		
		let(:user) { FactoryGirl.create(:user) }
		let(:cocktail) { FactoryGirl.create(:cocktail) }
		before do
			@first_tool = cocktail.tools.create(tool: "straws")
			@second_tool = cocktail.tools.create(tool: "muddler")
			@first_ingredient = cocktail.ingredients.create(ingredient: "vodka", measure: 2, unit: "shots",
															decoration: "false" )
			@second_ingredient = cocktail.ingredients.create(ingredient: "juice", measure: 2, unit: "shots",
															decoration: "false" )
			@first_direction = cocktail.directions.create(direction: "Muddle everything")
			@second_direction = cocktail.directions.create(direction: "Shake then serve")
		end

	    before { visit cocktail_path(cocktail) }

	    it { should have_selector('h1', text: cocktail.name.titleize) }
	    it { should have_selector('title', text: cocktail.name.titleize) }
	    it { should have_content(cocktail.family.titleize) }
	    it { should have_content(cocktail.makes) }
	    it { should have_content(cocktail.glass) }

	    # this should be fixed

	    # describe "glass chilled" do
	    # 	before { cocktail.toggle(:chilled) }
	    # 	it { should have_content("chilled") }
	    # end

		describe "glass not chilled" do
	    	before { cocktail.chilled = FALSE }
	    	it { should_not have_content("chilled") }
	    end

	    describe "tools" do
	    	it { should have_content(cocktail.tools.first.tool) }
	    	it { should have_content(cocktail.tools.second.tool) }
	    end

	    describe "ingredients" do
	    	it { should have_content(cocktail.ingredients.first.ingredient) }
	    	it { should have_content(cocktail.ingredients.second.ingredient) }

	    	# this should be fixed

	    	# describe "decoration" do
	    	# 	before { cocktail.ingredients.first.toggle(:decoration) }
	    	# 	it { should have_content("decorate") }
	    	# end
	    end

	    describe "directions" do
	    	it { should have_content(cocktail.directions.first.direction) }
	    	it { should have_content(cocktail.directions.second.direction) }
	    end

	    describe "vote buttons" do

	    	describe "vote" do
		    	before do
		    		sign_in user
		    		visit cocktail_path(cocktail)
		    	end

		    	it { should have_button('Vote') }

		    	it "should increment vote count by 1" do
		    		expect do
		    			click_button "Vote"
		    		end.to change(user.votes, :count).by(1)
		    	end

		    	describe "toggle the button" do
		    		before { click_button "Vote" }
		    		it { should have_button "Un-Vote" }
		    	end
		    end

	    	describe "unvote" do
	    		before do
	    			sign_in user
	    			user.vote!(cocktail)
	    			visit cocktail_path(cocktail)
	    		end

	    		it { should have_button('Un-Vote') }

	    		it "should decrement vote count by 1" do
		    		expect do
		    			click_button "Un-Vote"
		    		end.to change(user.votes, :count).by(-1)
		    	end

		    	describe "toggle the button" do
		    		before { click_button "Un-Vote" }
		    		it { should have_button "Vote" }
		    	end
	    	end
	    end

	end	

	describe "index" do
	    before do
		    FactoryGirl.create(:cocktail)
		    FactoryGirl.create(:cocktail, name: "Bob")
		    FactoryGirl.create(:cocktail, name: "Ben")
		    visit cocktails_path
	    end

	    it { should have_selector('title', text: 'Cocktails') }
	    it { should have_selector('h1',    text: 'Cocktails') }

		describe "pagination" do

			before(:all) { 30.times { FactoryGirl.create(:cocktail) } }
			after(:all) { Cocktail.delete_all }

			it { should have_selector('div.pagination') }

			it "should list each cocktail" do
				Cocktail.paginate(page: 1).each do |cocktail|
					page.should have_selector('li', text:cocktail.name)
				end
			end
		end

		describe "delete links" do

			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit cocktails_path
				end

				it { should have_link('delete', href: cocktail_path(Cocktail.first)) }
				it "should be able to delete a cocktail" do
					expect { click_link('delete') }.to change(Cocktail, :count).by(-1)
				end

			end
		end

    end

	describe "New cocktail Page" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_cocktail_path
		end

		it { should have_selector('h1', text:'Create Your Cocktail') }
		it { should have_selector('title', text: 'CKTLS | Create') }
	end

	describe "Create new cocktail" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_cocktail_path
		end

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
				fill_in "Tool",			with: "Muddler"
				fill_in "Ingredient",	with: "Whisky"
				fill_in "Measure",		with: 2
				fill_in "Unit",			with: "Shots"
				fill_in "Direction",	with: "Mix and serve"
			end

			it 'should create a cocktail' do
				expect { click_button submit }.to change(Cocktail, :count).by(1)
			end

			describe "after saving the cocktail" do
				before { click_button submit }
				
				it { should have_selector('h1',    text: "Example Cocktail") }
			end
		end
	end

	describe "edit cocktail" do
	    let(:cocktail) { FactoryGirl.create(:cocktail) }
	    let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
	    	visit edit_cocktail_path(cocktail)
	    end	    

	    describe "page" do
	    	it { should have_selector('h1',    text: "Update cocktail") }
	    	it { should have_selector('title', text: "Edit cocktail") }
	    end

	    describe "with invalid information" do
	    	before do
	    		fill_in "Name",			with: " "

	    		click_button "Create my cocktail"
	    	end

	    	it { should have_content('error') }
	    end

	    describe "with valid information" do
      		let(:new_name)  { "New Name" }
      		before do
		        fill_in "Name",         with: new_name
		        select "Fruity",		from: "Family"
				fill_in "Makes",		with: 2
				select "Martini glass", from: "Glass"
				select "No",			from: "Chilled"
		        
		        click_button "Create my cocktail"
      		end

		    it { should have_selector('title', text: new_name) }
		    it { should have_selector('div.alert.alert-success') }
		    specify { cocktail.reload.name.titleize.should  == new_name }
    	end

    end
end
