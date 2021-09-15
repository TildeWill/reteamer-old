module People
  def self.create(effective_date, attributes)
    ApplicationRecord.transaction do
      maybe_supervisor = attributes[:supervisor]&.send(:model)
      if maybe_supervisor&.effective_at && maybe_supervisor&.effective_at <= effective_date.end_of_day
        supervisor_id = maybe_supervisor&.id
      elsif maybe_supervisor
        raise "Supervisor is from the future!!!"
      end

      model = Model.new({
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        title: attributes[:title],
        supervisor_id: supervisor_id
      })
      model.meta = Meta.new_prototype(effective_date)
      model.save
      Person.new_from_model(model)
    end
  end

  def self.find_for(effective_date)
    models = Model.find_for(effective_date)
    models.map{ |model| Person.new_from_model(model) }
  end

  def self.roots(effective_date)
    models = Model.find_for(effective_date).roots
    models.map{ |model| Person.new_from_model(model) }
  end
end
