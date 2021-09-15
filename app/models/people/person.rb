module People
  # --- Entity for the outside world
  class Person
    include ActiveModel::Model
    delegate :first_name, :last_name, :title, to: :model

    def id
      model&.proto_id
    end

    def self.new_from_model(model)
      person = Person.new
      person.send(:model=, model)
      person
    end

    def supervisor
      Person.new_from_model(model.supervisor)
    end

    def subordinates(effective_date)
      model.subordinates.find_for(effective_date).map do |report|
        Person.new_from_model(report)
      end
    end

    def manager=(manager)
      model.manager = manager.send(:model)
    end

    def update(effective_date, attributes)
      new_attributes = {
        first_name: attributes[:first_name] || model.first_name,
        last_name: attributes[:last_name] || model.last_name,
        title: attributes[:title] || model.title,
        supervisor_id: attributes[:supervisor_id] || model.supervisor_id,
      }
      model = Model.new(new_attributes)

      ApplicationRecord.transaction do
        model.meta = Meta.update_prototype(model.proto_id, effective_date)
        model.save
      end

      return self
    end

    def as_json(options = nil)
      {
        id: id,
        name: [first_name, last_name].join(" "),
        parentId: supervisor.id,
        title: title,
        gravatar_hash: Digest::MD5.hexdigest("will.read@gmail.com".strip.downcase)
      }
    end

    private
    attr_accessor :model
  end
end
