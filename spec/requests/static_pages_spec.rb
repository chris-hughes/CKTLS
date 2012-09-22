require 'spec_helper'

describe "StaticPages" do

	describe "Home Page " do
		it "should have the h1 'CKTLS'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'CKTLS')
		end

		it "should have the title 'Home'" do
			visit '/static_pages/home'
			page.should have_selector('title', :text => 'CKTLS | Home')
		end
	end

	describe "About Page " do
		it "should have the h1 'About'" do
			visit '/static_pages/about'
			page.should have_selector('h1', :text => 'About')
		end

		it "should have the title 'About'" do
			visit '/static_pages/about'
			page.should have_selector('title', :text => 'CKTLS | About')
		end
	end

	describe "Contact Page " do
		it "should have the h1 'Contact'" do
			visit '/static_pages/contact'
			page.should have_selector('h1', :text => 'Contact')
		end

		it "should have the title 'Contact'" do
			visit '/static_pages/contact'
			page.should have_selector('title', :text => 'CKTLS | Contact')
		end
	end

end
