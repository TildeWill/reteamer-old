module Assignments
  class Assignment
    include ActiveModel::Model
    delegate :role_on_team, :active, :active?, :effective_at, to: :model

    # validate :team_and_person_must_both_be_in_effect
    #
    # def team_and_person_must_both_be_in_effect
    #   if Person.any?(person_id, effective_at) && Team.any?(team_id, effective_at)
    #     errors.add("Can't assign person to team that doesn't exist yet")
    #   end
    # end

    def person_id
      model&.person_proto_id
    end

    def team_id
      model&.team_proto_id
    end

    def self.new_from_model(model)
      wrapper = Assignment.new
      wrapper.send(:model=, model)
      wrapper
    end

    def self.create(effective_date, attributes)
      model = Model.new({
        person_proto_id: attributes[:person_id],
        team_proto_id: attributes[:team_id],
        role_on_team: attributes[:role_on_team],
        active: attributes[:active] || true,
      })
      model.meta = Meta.new_prototype(effective_date, Model)
      if People::Person.any?(effective_date, model.person_proto_id) && Teams::Team.any?(effective_date, model.team_proto_id)
        model.save
      else
        raise "Can't assign person to team that doesn't exist yet"
      end
      Assignment.new_from_model(model)
    end

    def update(effective_date, attributes)
      new_attributes = {
        person_proto_id: attributes.fetch(:person_id, person_id),
        team_proto_id: attributes.fetch(:team_id, team_id),
        role_on_team: attributes.fetch(:role_on_team, role_on_team),
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
      models.map { |model| Assignment.new_from_model(model) }
    end

    def self.delete_all
      Model.delete_all
    end

    def as_json(options = nil)
      {
        person_id: person_id,
        team_id: team_id,
        role_on_team: role_on_team,
      }
    end

    private

    attr_accessor :model
  end
end
