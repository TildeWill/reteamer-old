module People
  # --- Entity for the outside world
  class Person
    include ActiveModel::Model
    delegate :first_name, :last_name, :title, to: :model

    def self.new_from_model(model)
      person = Person.new
      person.send(:model=, model)
      person
    end

    def update(effective_date, attributes)
      new_attributes = {
        first_name: attributes[:first_name] || model.first_name,
        last_name: attributes[:last_name] || model.last_name,
        title: attributes[:title] || model.title,
        manager_id: attributes[:manager_id] || model.manager_id,
      }
      model = Model.new(new_attributes)

      ApplicationRecord.transaction do
        model.meta = Meta.update_prototype(model.proto_id, effective_date)
        model.save
      end

      return self
    end

    private
    attr_accessor :model
  end
end
