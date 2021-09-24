module Connections
  class Connection
    include ActiveModel::Model
    delegate :label, :active, :active?, to: :model

    def other_supervisor_id
      model&.other_supervisor_proto_id
    end

    def person_id
      model&.person_proto_id
    end

    def self.new_from_model(model)
      connection = Connection.new
      connection.send(:model=, model)
      connection
    end

    def update(effective_date, attributes)
      new_attributes = {
        person_proto_id: attributes.fetch(:person_id, person_id),
        other_supervisor_proto_id: attributes.fetch(:other_supervisor_id, other_supervisor_id),
        active: attributes.fetch(:active, active)
      }
      new_model = Model.new(new_attributes)

      ApplicationRecord.transaction do
        new_model.meta = Meta.update_prototype(model.proto_id, effective_date, Model)
        new_model.save
      end

      self.model = new_model
      return self
    end

    def as_json(options = nil)
      {
        from: person_id,
        to: other_supervisor_id,
        label: label,
      }
    end

    private
    attr_accessor :model
  end
end
