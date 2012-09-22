require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Home Page " do
		before { visit root_path }
		it { should have_selector('h1', :text => 'CKTLS') }
		it { should have_selector('title', :text => 'CKTLS | Home') }
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

end
