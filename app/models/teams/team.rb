module Teams
  class Team
    include ActiveModel::Model
    delegate :name, :active, :active?, to: :model

    def id
      model&.proto_id
    end

    def parent_id
      model&.parent_proto_id
    end

    def self.new_from_model(model)
      wrapper = Team.new
      wrapper.send(:model=, model)
      wrapper
    end

    def self.create(effective_date, attributes)
      model = Model.new({
        name: attributes[:name],
        parent_proto_id: attributes[:parent_proto_id],
        active: attributes[:active] || true,
      })
      model.meta = Meta.new_prototype(effective_date, Model)
      model.save
      Team.new_from_model(model)
    end

    def update(effective_date, attributes)
      new_attributes = {
        name: attributes.fetch(:name, name),
        parent_proto_id: attributes.fetch(:parent_proto_id, parent_id),
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

    def self.any?(effective_date, person_proto_id)
      models = Model.where(proto_id: person_proto_id).find_for(effective_date)
      models.present?
    end

    def self.delete_all
      Model.delete_all
    end

    def as_json(options = nil)
      {
        name: name,
        parent_id: parent_id,
      }
    end

    private
    attr_accessor :model
  end
end
