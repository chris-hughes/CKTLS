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

          mod = n % 7
          family = case mod
              when 0 then "Fabulously Fruity"
              when 1 then "Cool and Refreshing"
              when 2 then "Sparkling Gems"
              when 3 then "Tangy Tongue Teasers"
              when 4 then "Winter Warmers"
              when 5 then "Rich and Creamy"
              else "Sensational Shots"
          end

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

      cocktails = Cocktail.all
      2.times do
        ingredient = "Vodka"
        measure = 2
        unit = "Shots"
        decoration = false
        cocktails.each { |cocktail| cocktail.ingredients.create!(ingredient: ingredient,
                                                                 measure: measure,
                                                                 unit: unit,
                                                                 decoration: decoration) }
      end

      cocktails = Cocktail.all
      2.times do
        direction = "Shake and serve"
        cocktails.each { |cocktail| cocktail.directions.create!(direction: direction) }
      end

  	end
end