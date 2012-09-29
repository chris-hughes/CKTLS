require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Home Page " do
		before { visit root_path }
		it { should have_selector('h1', :text => 'CKTLS') }
		it { should have_selector('title', :text => 'CKTLS | Home') }
	end

	describe "Cocktails Page" do
		before { visit cocktails_path }
		it { should have_selector('h1', text: 'Cocktails') }
		it { should have_selector('title', text: 'CKTLS | Cocktails') }
	end

	describe "About Page " do
		before { visit about_path }
		it { should have_selector('h1', :text => 'About') }
		it { should have_selector('title', :text => 'CKTLS | About') }
	end

	describe "Contact Page " do
		before { visit contact_path }
		it { should have_selector('h1', :text => 'Contact') }
		it { should have_selector('title', :text => 'CKTLS | Contact') }
	end

	it "should have the right links on the layout" do
	    visit root_path
	    click_link "Cocktails"
	    page.should have_selector 'title', text: 'CKTLS | Cocktails'
	    click_link "About"
	    page.should have_selector 'title', text: 'CKTLS | About'
	    click_link "Contact"
	    page.should have_selector 'title', text: 'CKTLS | Contact'
	    click_link "Home"
	    click_link "Sign up now!"
	    page.should have_selector 'title', text: 'CKTLS | Sign up'
	    click_link "CKTLS"
	    page.should have_selector 'title', text: 'CKTLS | Home'
  	end

end
