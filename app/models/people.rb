module People
  def self.create(effective_date, attributes)
    ApplicationRecord.transaction do
      model = Model.new({
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        title: attributes[:title],
        supervisor_id: attributes[:supervisor]&.send(:model)&.id
      })
      model.meta = Meta.new_prototype(effective_date)
      model.save
      Person.new_from_model(model)
    end
  end

  def self.find_for(effective_date)
    models = Model
                  .select("DISTINCT proto_id, *")
                  .where(effective_at: 30.years.ago..effective_date.end_of_day)
                  .order(effective_at: :desc)
    models.map{ |model| Person.new_from_model(model) }
  end

  def self.roots(effective_date)
    models = Model
               .select("DISTINCT proto_id, *")
               .where(effective_at: 30.years.ago..effective_date.end_of_day)
               .order(effective_at: :desc)
               .roots
    models.map{ |model| Person.new_from_model(model) }
  end
end
