require "rails_helper"

RSpec.describe People do
  it "let's you save multiple objects for the same day" do
    People.create(Date.current, first_name: "Peter")
    People.create(6.days.from_now, first_name: "Paul")
    People.create(2.days.from_now, first_name: "Mary")

    expect(People.find_for(6.days.from_now).count).to eq(3)
    expect(People.find_for(2.days.from_now).count).to eq(2)
    expect(People.find_for(Date.current).count).to eq(1)
  end

  it "let's you update the same object" do
    person = People.create(Date.current, first_name: "Peter", last_name: "Singer")
    person.update(2.days.from_now, first_name: "Paul")
    person.update(2.days.from_now, first_name: "Paulz")
    person.update(1.days.from_now, first_name: "Mary")

    peter = People.find_for(Date.current).first
    expect(peter).to be_a(People::Person)
    expect(peter.first_name).to eq("Peter")
    expect(peter.last_name).to eq("Singer")
    mary = People.find_for(1.days.from_now).first
    expect(mary.first_name).to eq("Mary")
    expect(mary.last_name).to eq("Singer")
    paulz = People.find_for(2.days.from_now).first
    expect(paulz.first_name).to eq("Paulz")
    expect(paulz.last_name).to eq("Singer")
  end

  it "returns the manager as a person" do
    manager = People.create(Date.current, first_name: "Michael")
    subordinate = People.create(Date.current, first_name: "Jim", manager: manager)

    expect(subordinate.manager.id).to eq(manager.id)
    expect(manager.reports.map(&:id)).to eq([subordinate.id])
  end
end
