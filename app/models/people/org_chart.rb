module People
  class OrgChart
    def self.tree_data(effective_date)
      People.roots(effective_date).map do |person|
        data(person)
      end
    end

    def self.data(person)
      subordinates = person.subordinates.map do |subordinate|
        data(subordinate)
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
