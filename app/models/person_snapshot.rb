class PersonSnapshot < ApplicationRecord
  belongs_to :manager, class_name: "PersonSnapshot", optional: true

  def meta
    @meta ||= Meta.new(proto_id, effective_at)
  end

  def meta=(meta)
    self.proto_id = meta.proto_id
    self.effective_at = meta.effective_at

    @meta = meta
  end
end
