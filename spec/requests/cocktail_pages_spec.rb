require 'spec_helper'

describe "CocktailPages" do

	subject { page }

	describe "cocktail show page" do

		let(:cocktail) { FactoryGirl.create(:cocktail) }
		before do
			@first_tool = cocktail.tools.create(tool: "straws")
			@second_tool = cocktail.tools.create(tool: "muddler")
		end

	    before { visit cocktail_path(cocktail) }

	    it { should have_selector('h1', text: cocktail.name.titleize) }
	    it { should have_selector('title', text: cocktail.name.titleize) }
	    it { should have_content(cocktail.family.titleize) }
	    it { should have_content(cocktail.makes) }
	    it { should have_content(cocktail.glass) }

	    # this needs to be fixed
	    
	    # describe "glass chilled" do
	    # 	before do 
	    # 		cocktail.toggle(:chilled)
	    # 	end
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

	    		click_button "Save changes"
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
		        
		        click_button "Save changes"
      		end

		    it { should have_selector('title', text: new_name) }
		    it { should have_selector('div.alert.alert-success') }
		    specify { cocktail.reload.name.titleize.should  == new_name }
    	end

    end
end
