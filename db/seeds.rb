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

for i in 1..100 do
  10.times do
    User.find(i).houses.create(house_type: rand(1..2), foreigner: rand(1..2), school_id: rand(1..4), title: BetterLorem.w(4, true, true), description: BetterLorem.p(2, true, true), city: '台北市', district: '中正區', zipcode: '100', address: BetterLorem.w(5, true, true), price: rand(1000..9999))
  end
end

for i in 1..SchoolData.school_categories.size - 1 do
  School.create(name: SchoolData.school_categories.key(i))
end

House.all.each do |h|
  h.comments.create(author_id: rand(1..100), content: BetterLorem.p(2, true, true))
end