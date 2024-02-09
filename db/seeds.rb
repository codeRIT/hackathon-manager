# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  ['common', Rails.env].each do |seedfile|
    seed_file = "#{Rails.root}/db/seeds/#{seedfile}.rb"
    if File.exists?(seed_file)
      puts "- - Seeding data from file: #{seedfile}"
      require seed_file
    end
  end
end

puts "Done"
