module People
  def self.create(effective_date, attributes)
    ApplicationRecord.transaction do
      if(attributes[:supervisor_id])
        maybe_supervisor = Model.find_by_proto_id(attributes[:supervisor_id])
        unless maybe_supervisor&.effective_at && maybe_supervisor&.effective_at <= effective_date.end_of_day
          raise "Supervisor doesn't exist or is from the future!!!"
        end
      end

      model = Model.new({
        employee_id: attributes[:employee_id],
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        title: attributes[:title],
        supervisor_proto_id: attributes[:supervisor_id],
        active: attributes[:active] || true,
        image_url: attributes[:image_url],
        contractor: attributes[:contractor] || false
      })
      model.meta = Meta.new_prototype(effective_date, Model)
      model.save
      Person.new_from_model(model)
    end
  end

  def self.find_for(effective_date)
    models = Model.find_for(effective_date)
    models.map{ |model| Person.new_from_model(model) }
  end

  def self.histogram
    Model.select('COUNT(*) AS value, effective_at::date AS date').group('date').order(:date)
  end

  def self.delete_all
    Model.delete_all
  end
end
