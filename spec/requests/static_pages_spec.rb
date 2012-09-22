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

end
