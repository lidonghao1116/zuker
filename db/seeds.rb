# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..9 do
  a = User.create(:first_name => "peter#{i}", :last_name => "thiel#{i}", :phone_number => "092008518#{i}", :password => "123456")
  a.generate_pin
end

for i in 0..SchoolData.school_categories.size - 1 do
  School.create(:name => SchoolData.school_categories.key(i))
end