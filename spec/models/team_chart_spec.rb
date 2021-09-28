require 'rails_helper'

describe TeamChart do
  it 'gets the teams and people for the specified date' do
    avengers = Teams::Team.create(Date.current, name: "Avengers")
    west_coast_avengers = Teams::Team.create(3.days.from_now.to_date, name: "West Coast Avengers", parent_id: avengers.id)
    great_lakes_avengers = Teams::Team.create(Date.current, name: "Great Lakes Avengers", parent_id: avengers.id)

    iron_man = People::Person.create(Date.current, first_name: "Iron", last_name: "Man")
    Assignments::Assignment.create(Date.current, person_id: iron_man.id, team_id: avengers.id)

    hawkeye = People::Person.create(Date.current, first_name: "Hawkeye")
    Assignments::Assignment.create(Date.current, person_id: hawkeye.id, team_id: avengers.id)
    expect{Assignments::Assignment.create(Date.current, person_id: hawkeye.id, team_id: west_coast_avengers.id)}.to raise_error("Can't assign person to team that doesn't exist yet")

    team_chart = TeamChart.find_for(Date.current)
    p team_chart.map(&:name)
    expect(team_chart.count).to eq(4)
  end
end
