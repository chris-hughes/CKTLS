FactoryGirl.define do
	factory :user do
	    sequence(:name)  { |n| "Person #{n}" }
	    sequence(:email) { |n| "person_#{n}@example.com"}   
	    password "foobar"
	    password_confirmation "foobar"

	    factory :admin do
	    	admin true
	    end
	end

	factory :cocktail do
		sequence(:name) { |n| "Cocktail #{n}" }
		family "Fruity"
		makes 2
		glass "Martini glass"
		chilled "No"
	end

end