class Person
  def self.create(effective_date, attributes)
    ApplicationRecord.transaction do
      snapshot = PersonSnapshot.new(attributes)
      snapshot.meta = Meta.new_prototype(effective_date)
      snapshot.tap(&:save)
    end
  end

  def self.find_for(effective_date)
    PersonSnapshot.where(effective_at: 30.years.ago..effective_date.end_of_day)
  end
end
