require "rails_helper"

RSpec.describe Person do
  it "let's you save multiple objects for the same day" do
    Person.create(Date.current, first_name: "Peter")
    Person.create(6.days.from_now, first_name: "Paul")
    Person.create(2.days.from_now, first_name: "Mary")

    expect(Person.find_for(6.days.from_now.to_date).count).to eq(3)
    expect(Person.find_for(2.days.from_now.to_date).count).to eq(2)
    expect(Person.find_for(Date.current).count).to eq(1)
  end
end
