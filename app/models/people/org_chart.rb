module People
  class OrgChart
    def self.tree_data(effective_date)
      People.roots(effective_date).map do |person|
        data(person, effective_date)
      end
    end

    def self.data(person, effective_date)
      subordinates = person.subordinates(effective_date).map do |subordinate|
        data(subordinate, effective_date)
      end

      {
        first_name: person.first_name,
        last_name: person.last_name,
        title: person.title,
        subordinates: subordinates
      }
    end
  end
end
