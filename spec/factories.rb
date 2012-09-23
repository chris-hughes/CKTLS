FactoryGirl.define do
	factory :user do
		name					"Chris Hughes"
		email					"Chris@Hughes.com"
		password				"foobar"
		password_confirmation	"foobar"
	end
end