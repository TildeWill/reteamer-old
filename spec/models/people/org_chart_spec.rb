require "rails_helper"

RSpec.describe People::OrgChart do
  it "returns the org chart for the specified day" do
    grand_boss = People.create(Date.current, first_name: "M. Bison", title: "CEO")
    boss = People.create(Date.current, first_name: "Vega", title: "CTO", supervisor: grand_boss)
    other_boss = People.create(Date.current, first_name: "Sagat", title: "CFO", supervisor: grand_boss)
    underling1 = People.create(Date.current, first_name: "Mario", title: "Staff Plumber", supervisor: boss)
    underling2 = People.create(Date.current, first_name: "Luigi", title: "Principal Plumber", supervisor: other_boss)
    puts JSON.pretty_generate(People::OrgChart.tree_data(Date.current))
  end
end
