module Teams
  class Team
    include ActiveModel::Model
    # delegate :label, :active, :active?, to: :model
    #
    # def other_supervisor_id
    #   model&.other_supervisor_proto_id
    # end
    #
    # def person_id
    #   model&.person_proto_id
    # end

    def self.new_from_model(model)
      wrapper = Team.new
      wrapper.send(:model=, model)
      wrapper
    end

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

    def self.find_for(effective_date)
      models = Model.find_for(effective_date)
      models.map{ |model| Team.new_from_model(model) }
    end

    def self.delete_all
      Model.delete_all
    end

    def as_json(options = nil)
      {
        # from: person_id,
        # to: other_supervisor_id,
        # label: label,
      }
    end

    private
    attr_accessor :model
  end
end
