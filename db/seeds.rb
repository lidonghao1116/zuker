# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..100 do
  #User.create(first_name: "peter#{i}", last_name: "thiel#{i}", phone_number: "092008518#{i}", password: "123456", sign_with_zuker: true).generate_pin
  User.create(first_name: "peter#{i}", last_name: "thiel#{i}", phone_number: "0920#{rand(000000..999999).to_s.rjust(6, "0")}", password: "123456", sign_with_zuker: true).generate_pin
end

User.create(first_name: "peter", last_name: "thiel", phone_number: "0920085183", password: "123456", sign_with_zuker: true).generate_pin

5.times do
  User.last.comments.create(content: "Hi Peter, this is rails seed#{rand(1..100)}.", author_id: rand(1..100))
end

for i in 1..10 do
  1.times do
    User.find(i).houses.create(house_type: rand(1..2), foreigner: rand(1..2), school_id: rand(1..SchoolData.school_categories.size), title: BetterLorem.w(4, true, true), description: BetterLorem.p(2, true, true), city: '台北市', district: '永和區', zipcode: '100', address: '忠孝街5-8號', price: rand(1000..9999), person: rand(1..8) )
  end
end

for i in 1..SchoolData.school_categories.size do
  School.create(name: SchoolData.school_categories.key(i))
end

House.all.each do |h|
  h.comments.create(author_id: rand(1..100), content: BetterLorem.p(2, true, true))
  h.rooms.create(title: BetterLorem.w(4, true, true))
end

House.first.comments.create(author_id: rand(1..100), content: BetterLorem.p(2, true, true))
House.first.comments.first.comments.create(author_id: rand(1..100), content: BetterLorem.p(2, true, true))
House.first.comments.first.comments.first.comments.create(author_id: rand(1..100), content: BetterLorem.p(2, true, true))