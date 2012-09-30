namespace :db do
  	desc "Fill database with sample data"
  	task populate: :environment do
    	admin = User.create!(name: "Example User",
                 email: "user@example.com",
                 password: "foobar",
                 password_confirmation: "foobar")
      admin.toggle!(:admin)
    	
    	99.times do |n|
      		name  = Faker::Name.name
      		email = "example-#{n+1}@cktls.com"
      		password  = "password"
      		User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    	end

      99.times do |n|
          name = Faker::Name.name
          family = "Fruity"
          makes = 2
          glass = "Martini glass"
          chilled ="No"
          Cocktail.create!(name: name,
                           family: family,
                           makes: makes,
                           glass: glass,
                           chilled: chilled)
      end

      cocktails = Cocktail.all
      2.times do
        tool = "Cocktail shaker"
        cocktails.each { |cocktail| cocktail.tools.create!(tool: tool) }
      end


  	end
end