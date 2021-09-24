if Rails.env.production?
  raise "Can't run seeds on production DB because it'll destroy data"
end

User.delete_all
People.delete_all
Connections.delete_all

User.create(first_name: "Will", last_name: "Read", email: "will.read@gmail.com", admin: true, password: 'password', password_confirmation: 'password')

#
# People of 30 Rock
#
jack    = People.create(Date.current, employee_id: "NBC-279F0", first_name: "Jack", last_name: "Donaghy", title: "Vice President of East Coast Television and Microwave Oven Programming", image_url: "https://www.beverlyhillsmagazine.com/wp-content/uploads/beverly-hills-magazine-alec-baldwin-hollywood-celebrities-famous-actors-1.jpg")
liz     = People.create(Date.current, employee_id: "NBC-22B75", first_name: "Liz", last_name: "Lemon", title: "Head Writer", supervisor_id: jack.id, image_url: "https://otb.cachefly.net/wp-content/uploads/2010/03/Tina-Fey-Liz-Lemon.jpg")
pete    = People.create(Date.current, employee_id: "NBC-386D3", first_name: "Pete", last_name: "Hornberger", title: "Producer", supervisor_id: jack.id, image_url: "https://screenfiction.org/content/image/0/113/668/0a9e4d88-regular.webp")
jon     = People.create(Date.current, employee_id: "NBC-981D7", first_name: "Jonathan", title: "Assistant", supervisor_id: jack.id, image_url: "https://www.hollywoodreporter.com/wp-content/uploads/2012/08/maulik_pancholy_a_p.jpg")
# howard  = People.create(6.weeks.from_now.to_date, first_name: "Howard", last_name: "Jorgensen", title: "Vice President of Locomotives")

kenneth = People.create(Date.current, employee_id: "NBC-435R2", first_name: "Kenneth", last_name: "Parcell", title: "Page", supervisor_id: pete.id)
leo     = People.create(7.weeks.from_now.to_date, employee_id: "HTH-555O0", first_name: "Leo", last_name: "Spaceman", title: "Quack Doctor", supervisor_id: jack.id)

tracy   = People.create(Date.current, employee_id: "NBC-923H5", first_name: "Tracy", last_name: "Jordan", title: "Actor", supervisor_id: liz.id)
dotcom  = People.create(Date.current, first_name: "Walter \"Dot Com\"", last_name: "Slattery", title: "Entrepreneur", supervisor_id: tracy.id, contractor: true)
grizz   = People.create(Date.current, first_name: "Warren \"Grizz\"", last_name: "Griswald", title: "Talent Manager", supervisor_id: tracy.id, contractor: true)

# Add a dotted line for Kenneth who is also part of Tracy's entourage
errand_boy_connection = Connections.create(Date.current, person_id: kenneth.id, other_supervisor_id: tracy.id, label: "Errand Boy")

jenna   = People.create(Date.current, employee_id: "NBC-503Y2", first_name: "Jenna", last_name: "Maroney", title: "Actor", supervisor_id: liz.id)
josh    = People.create(Date.current, employee_id: "NBC-684N0", first_name: "Josh", last_name: "Girard", title: "Actor/Writer", supervisor_id: liz.id)
frank   = People.create(Date.current, employee_id: "NBC-494T7", first_name: "Frank", last_name: "Rossitano", title: "Writer", supervisor_id: liz.id, image_url: "https://carboncostume.com/wordpress/wp-content/uploads/2013/05/frankrossitano.jpg")
lutz    = People.create(Date.current, employee_id: "NBC-747S3", first_name: "Johnny", last_name: "Lutz", title: "Writer", supervisor_id: liz.id)
toofer  = People.create(Date.current, employee_id: "NBC-313V5", first_name: "Toofer", last_name: "Spurlock", title: "Writer", supervisor_id: liz.id)
cerie   = People.create(Date.current, employee_id: "NBC-8008S", first_name: "Cerie", last_name: "Xerox", title: "Assistant", supervisor_id: liz.id)

don     = People.create(14.weeks.from_now.to_date, employee_id: "GE-357R0", first_name: "Don", last_name: "Geiss", title: "CEO of General Electric")
jack.update(14.weeks.from_now.to_date, supervisor_id: don.id)
devon   = People.create(18.weeks.from_now.to_date, employee_id: "NBC-64Y4K", first_name: "Devon", last_name: "Banks", title: "Vice President of West Coast News, Web Content, and Theme Park Talent Relations", supervisor_id: don.id)
# end of season 1

# season 2
lenny   = People.create(2.years.from_now.to_date, first_name: "Lenny", last_name: "Wosniak", title: "Private Investigator", supervisor_id: jack.id, contractor: true)
# end of season 2

# season 3
josh.update(4.years.from_now.to_date, terminated: true) # Josh leaves after season 3
# end of season 3

# season 4
danny   = People.create(4.years.from_now.to_date, employee_id: "NBC-488P8", first_name: "Danny", last_name: "Baker", title: "Actor", supervisor_id: liz.id)
don.update(5.years.from_now.to_date, terminated: true) # Geiss dies
jack.update(5.years.from_now.to_date, supervisor_id: nil)
devon.update(5.years.from_now.to_date, terminated: true)
# end of season 4

# season 5
hank    = People.create(5.years.from_now.to_date, employee_id: "KBL-001", first_name: "Hank", last_name: "Hooper", title: "CEO Kabletown", image_url: "https://static.wikia.nocookie.net/30rock/images/6/67/Tumblr_mpzxbgnTaM1qd0hs5o1_500.jpg/revision/latest/top-crop/width/360/height/450?cb=20151030185818")
jack.update(5.years.from_now.to_date, supervisor_id: hank.id)
angie = People.create(5.years.from_now.to_date, first_name: "Angie", last_name: "Jordan", title: "Actor/Producer", supervisor_id: liz.id, contractor: true)
# end of season 5

josh.update(6.years.from_now.to_date, terminated: false) # Josh comes back for the season finale


