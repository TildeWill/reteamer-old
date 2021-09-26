require "rails_helper"

RSpec.describe People do
  it "let's you save multiple objects for the same day" do
    People::Person.create(Date.current, first_name: "Peter")
    People::Person.create(6.days.from_now, first_name: "Paul")
    People::Person.create(2.days.from_now, first_name: "Mary")

    expect(People::Person.find_for(6.days.from_now).count).to eq(3)
    expect(People::Person.find_for(2.days.from_now).count).to eq(2)
    expect(People::Person.find_for(Date.current).count).to eq(1)
  end

  it "let's you update the same object" do
    person = People::Person.create(Date.current, first_name: "Peter", last_name: "Singer")
    person.update(2.days.from_now, first_name: "Paul")
    person.update(2.days.from_now, first_name: "Paulz")
    person.update(1.days.from_now, first_name: "Mary")

    today_people = People::Person.find_for(Date.current)
    expect(today_people.count).to eq(1)
    peter = today_people.first
    expect(peter).to be_a(People::Person)
    expect(peter.first_name).to eq("Peter")
    expect(peter.last_name).to eq("Singer")

    one_day_from_now_people = People::Person.find_for(1.days.from_now)
    expect(one_day_from_now_people.count).to eq(1)
    mary = one_day_from_now_people.first
    expect(mary.first_name).to eq("Mary")
    expect(mary.last_name).to eq("Singer")

    two_days_from_now_people = People::Person.find_for(2.days.from_now)
    expect(two_days_from_now_people.count).to eq(1)
    paulz = two_days_from_now_people.first
    expect(paulz.first_name).to eq("Paulz")
    expect(paulz.last_name).to eq("Singer")
  end
end
