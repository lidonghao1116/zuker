# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..9 do
  User.create(first_name: "peter#{i}", last_name: "thiel#{i}", phone_number: "092008518#{i}", password: "123456", sign_with_zuker: true).generate_pin
end

for i in 1..9 do
  House.create(title: BetterLorem.w(4, true, true), description: BetterLorem.p(2, true, true), address: BetterLorem.w(5, true, true), price: 987, owner_id: i )
end

for i in 0..SchoolData.school_categories.size - 1 do
  School.create(name: SchoolData.school_categories.key(i))
end

House.all.each_with_index do |h, i|
  h.comments.create(author_id: i+1, content: BetterLorem.p(2, true, true))
end