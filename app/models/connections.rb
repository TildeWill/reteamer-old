module Connections
  def self.create(effective_date, attributes)
    model = Model.new({
      person_proto_id: attributes[:person_id],
      other_supervisor_proto_id: attributes[:other_supervisor_id],
      active: attributes[:active] || true,
      label: attributes[:label]
    })
    model.meta = Meta.new_prototype(effective_date, Model)
    model.save
    Connection.new_from_model(model)
  end

  def self.find_for(effective_date)
    models = Model.find_for(effective_date)
    models.map{ |model| Connection.new_from_model(model) }
  end

  def self.delete_all
    Model.delete_all
  end
end
