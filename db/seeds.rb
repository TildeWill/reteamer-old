# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
grand_boss = People.create(Date.current, first_name: "M. Bison", title: "CEO")
boss = People.create(Date.current, first_name: "Vega", title: "CTO", supervisor: grand_boss)
other_boss = People.create(Date.current, first_name: "Sagat", title: "CFO", supervisor: grand_boss)
present_day_underling = People.create(Date.current, first_name: "Mario", title: "Staff Plumber", supervisor: boss)
future_underling = People.create(6.days.from_now, first_name: "Captain Toad", title: "Adventurer", supervisor: other_boss)
