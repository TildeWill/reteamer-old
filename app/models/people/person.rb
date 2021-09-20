module People
  # --- Entity for the outside world
  class Person
    include ActiveModel::Model
    delegate :first_name, :last_name, :title, :email, :supervisor_id, :terminated?, :image_url, to: :model

    def id
      model&.proto_id
    end

    def self.new_from_model(model)
      person = Person.new
      person.send(:model=, model)
      person
    end

    def subordinates(effective_date)
      Model.where(supervisor_id: id).find_for(effective_date).map do |report|
        Person.new_from_model(report)
      end
    end

    def update(effective_date, attributes)
      # maybe_supervisor = attributes[:supervisor]&.send(:model)
      # if maybe_supervisor&.effective_at && maybe_supervisor&.effective_at <= effective_date.end_of_day
      #   supervisor_id = maybe_supervisor&.id
      # elsif maybe_supervisor
      #   raise "Supervisor is from the future!!!"
      # end

      new_attributes = {
        first_name: attributes[:first_name] || model.first_name,
        last_name: attributes[:last_name] || model.last_name,
        title: attributes[:title] || model.title,
        supervisor_id: attributes[:supervisor_id] || model.supervisor_id,
        terminated: attributes[:terminated] || model.terminated,
        image_url: attributes[:image_url] || model.image_url
      }
      new_model = Model.new(new_attributes)

      ApplicationRecord.transaction do
        new_model.meta = Meta.update_prototype(model.proto_id, effective_date)
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
        employee_id: nil
      }
    end

    private
    attr_accessor :model
  end
end
