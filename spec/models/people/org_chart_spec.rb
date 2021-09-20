require "rails_helper"

RSpec.describe People::OrgChart do
  it "returns the org chart for the specified day" do
    grand_boss = People.create(Date.current, first_name: "M. Bison", title: "CEO")
    boss = People.create(Date.current, first_name: "Vega", title: "CTO", supervisor_id: grand_boss.id)
    other_boss = People.create(Date.current, first_name: "Sagat", title: "CFO", supervisor_id: grand_boss.id)
    present_day_underling = People.create(Date.current, first_name: "Mario", title: "Staff Plumber", supervisor_id: boss.id)
    expect{future_boss_error = People.create(6.days.ago, first_name: "Luigi", title: "Principal Plumber", supervisor_id: other_boss.id)}.to raise_error("Supervisor doesn't exist or is from the future!!!")
    future_underling = People.create(6.days.from_now, first_name: "Captain Toad", title: "Adventurer", supervisor_id: other_boss.id)
    puts JSON.pretty_generate(People::OrgChart.tree_data(Date.current))
  end
end
