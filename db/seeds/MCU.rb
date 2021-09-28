# based off of the summary here: https://collider.com/mcu-timeline-explained/

ssr = Teams::Team.create(Date.parse("1940-10-01"), name: "Strategic Scientific Reserve")
peggy = People::Person.create(Date.parse("1921-10-01"), first_name: "Peggy", last_name: "Carter")
peggy_assignment = Assignments::Assignment.create(Date.parse("1940-10-01"), person_id: peggy.id, team_id: ssr.id)

howard = People::Person.create(Date.parse("1917-10-01"), first_name: "Howard", last_name: "Stark")
stark_industries = Teams::Team.create(Date.parse("1939-09-30"), name: "Stark Industries")
howard_assignment = Assignments::Assignment.create(Date.parse("1939-09-30"), person_id: howard.id, team_id: stark_industries.id)

hydra = Teams::Team.create(Date.parse("1932-10-01"), name: "HYDRA")
heinz = People::Person.create(Date.parse("1933-01-01"), first_name: "Heinz", last_name: "Kruger")
warner = People::Person.create(Date.parse("1933-01-01"), first_name: "Warner", last_name: "Reinhardt")
zola = People::Person.create(Date.parse("1933-01-01"), first_name: "Arnim", last_name: "Zola")
red_skull = People::Person.create(Date.parse("1933-01-01"), first_name: "Johann", last_name: "Schmidt")
red_skull.update(Date.parse("1940-11-11"), first_name: "Red", last_name: "Skull")
red_skull_assignment = Assignments::Assignment.create(Date.parse("1933-01-01"), person_id: red_skull.id, team_id: hydra.id)
Assignments::Assignment.create(Date.parse("1933-01-01"), person_id: heinz.id, team_id: hydra.id)
warner_assignment = Assignments::Assignment.create(Date.parse("1933-01-01"), person_id: warner.id, team_id: hydra.id)
zola_assignment = Assignments::Assignment.create(Date.parse("1933-01-01"), person_id: zola.id, team_id: hydra.id)

captain_america = People::Person.create(Date.parse("1918-07-04"), first_name: "Steve", last_name: "Rogers")
captain_america.update(Date.parse("1943-06-22"), first_name: "Captain", last_name: "America")
Assignments::Assignment.create(Date.parse("1943-06-14"), person_id: captain_america.id, team_id: ssr.id)

dum_dum = People::Person.create(Date.parse("1918-07-04"), first_name: "Dum Dum", last_name: "Dugan")
gabe = People::Person.create(Date.parse("1918-07-04"), first_name: "Gabe", last_name: "Jones")
jim = People::Person.create(Date.parse("1918-07-04"), first_name: "Jim", last_name: "Morita")
james = People::Person.create(Date.parse("1918-07-04"), first_name: "James", last_name: "Falsworth")
jacques = People::Person.create(Date.parse("1918-07-04"), first_name: "Jacques", last_name: "Dernier")
bucky = People::Person.create(Date.parse("1917-07-04"), first_name: "Bucky", last_name: "Barnes")
howling_commandos = Teams::Team.create(Date.parse("1943-01-01"), name: "107th")
Assignments::Assignment.create(Date.parse("1943-01-01"), person_id: dum_dum.id, team_id: howling_commandos.id)
Assignments::Assignment.create(Date.parse("1943-01-01"), person_id: gabe.id, team_id: howling_commandos.id)
Assignments::Assignment.create(Date.parse("1943-01-01"), person_id: jim.id, team_id: howling_commandos.id)
Assignments::Assignment.create(Date.parse("1943-01-01"), person_id: james.id, team_id: howling_commandos.id)
Assignments::Assignment.create(Date.parse("1943-01-01"), person_id: jacques.id, team_id: howling_commandos.id)
Assignments::Assignment.create(Date.parse("1943-01-01"), person_id: bucky.id, team_id: howling_commandos.id)


howling_commandos.update(Date.parse("1944-01-01"), name: "Howling Commandos")
zola_assignment.update(Date.parse("1945-01-01"), active: false)

red_skull_assignment.update(Date.parse("1945-03-04"), active: false) # red skull gets defeated and sends himself to the realm of Vorimir
warner_assignment.update(Date.parse("1945-05-21"), active: false) # captured by the SSR!

shield = Teams::Team.create(Date.parse("1949-01-01"), name: "S.H.I.E.L.D.")
peggy_assignment.update(Date.parse("1949-01-01"), team_id: shield.id)
howard_assignment2 = Assignments::Assignment.create(Date.parse("1949-01-01"), person_id: howard.id, team_id: shield.id)
zola_assignment.update(Date.parse("1949-05-01"), active: true, team_id: shield.id)

p "MARVEL!!!!!!!!!!!!!!!!!!!!"
