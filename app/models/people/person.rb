module People
  # --- Entity for the outside world
  class Person
    include ActiveModel::Model
    delegate :first_name, :last_name, :title, :email, :active?, :image_url, :contractor, :contractor?, :employee_id, to: :model

    def id
      model&.proto_id
    end

    def supervisor_id
      model&.supervisor_proto_id
    end

    def self.new_from_model(model)
      person = Person.new
      person.send(:model=, model)
      person
    end

    def update(effective_date, attributes)
      # maybe_supervisor = attributes[:supervisor]&.send(:model)
      # if maybe_supervisor&.effective_at && maybe_supervisor&.effective_at <= effective_date.end_of_day
      #   supervisor_id = maybe_supervisor&.id
      # elsif maybe_supervisor
      #   raise "Supervisor is from the future!!!"
      # end

      new_attributes = {
        employee_id: attributes.fetch(:employee_id, model.employee_id),
        first_name: attributes.fetch(:first_name, model.first_name),
        last_name: attributes.fetch(:last_name, model.last_name),
        title: attributes.fetch(:title, model.title),
        supervisor_proto_id: attributes.fetch(:supervisor_id, model.supervisor_proto_id),
        active: attributes.fetch(:active, model.active),
        image_url: attributes.fetch(:image_url, model.image_url),
        contractor: attributes.fetch(:contractor, model.contractor)
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
        id: id,
        name: [first_name, last_name].join(" "),
        parentId: supervisor_id,
        title: title,
        image_url: image_url || "https://www.gravatar.com/avatar/?s=50",
        employee_id: contractor ? '' : employee_id,
        isContractor: contractor?
      }
    end

    private
    attr_accessor :model
  end
end
