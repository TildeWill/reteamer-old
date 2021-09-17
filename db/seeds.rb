# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jack    = People.create(Date.current, first_name: "Jack", last_name: "Donaghy", title: "Vice President of East Coast Television and Microwave Oven Programming")
liz     = People.create(Date.current, first_name: "Liz", last_name: "Lemon", title: "Head Writer", supervisor: jack)
pete    = People.create(Date.current, first_name: "Pete", last_name: "Hornberger", title: "Producer", supervisor: jack)
jon     = People.create(Date.current, first_name: "Jonathan", title: "Assistant", supervisor: jack)
howard  = People.create(6.weeks.from_now.to_date, first_name: "Howard", last_name: "Jorgensen", title: "Vice President of Locomotives")

kenneth = People.create(Date.current, first_name: "Kenneth", last_name: "Parcell", title: "Page")
leo     = People.create(7.weeks.from_now.to_date, first_name: "Leo", last_name: "Spaceman", title: "Quack Doctor")

tracy   = People.create(Date.current, first_name: "Tracy", last_name: "Jordan", title: "Actor", supervisor: liz)
dotcom  = People.create(Date.current, first_name: "Walter \"Dot Com\"", last_name: "Slattery", title: "Entrepreneur", supervisor: tracy)
grizz   = People.create(Date.current, first_name: "Warren \"Grizz\"", last_name: "Griswald", title: "Talent Manager", supervisor: tracy)

jenna   = People.create(Date.current, first_name: "Jenna", last_name: "Maroney", title: "Actor", supervisor: liz)
josh    = People.create(Date.current, first_name: "Josh", last_name: "Girard", title: "Actor/Writer", supervisor: liz)
frank   = People.create(Date.current, first_name: "Frank", last_name: "Rossitano", title: "Writer", supervisor: liz)
lutz    = People.create(Date.current, first_name: "Johnny", last_name: "Lutz", title: "Writer", supervisor: liz)
toofer  = People.create(Date.current, first_name: "Toofer", last_name: "Spurlock", title: "Writer", supervisor: liz)
cerie   = People.create(Date.current, first_name: "Cerie", last_name: "Xerox", title: "Assistant", supervisor: liz)

don     = People.create(14.weeks.from_now.to_date, first_name: "Don", last_name: "Geiss", title: "CEO of General Electric")
jack.update(14.weeks.from_now.to_date, supervisor: don)
devon   = People.create(18.weeks.from_now.to_date, first_name: "Devon", last_name: "Banks", title: "Vice President of West Coast News, Web Content, and Theme Park Talent Relations", supervisor: don)
# end of season 1

# season 2
lenny   = People.create(2.years.from_now.to_date, first_name: "Lenny", last_name: "Wosniak", title: "Private Investigator")
# end of season 2

# season 3
# TODO: Josh leaves after season 3
# end of season 3

# season 4
danny   = People.create(4.years.from_now.to_date, first_name: "Danny", last_name: "Baker", title: "Actor", supervisor: liz)
#TODO: Geiss dies
jack.update(5.years.from_now.to_date, supervisor: nil)
# end of season 4

# season 5
hank    = People.create(5.years.from_now.to_date, first_name: "Hank", last_name: "Hooper", title: "CEO kabletown")
jack.update(5.years.from_now.to_date, supervisor: hank)
angie = People.create(5.years.from_now.to_date, first_name: "Angie", last_name: "Jordan", title: "Actor/Producer", supervisor: liz)
# end of season 5

#TODO: Josh comes back for the season finale
