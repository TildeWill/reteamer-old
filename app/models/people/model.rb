module People
  # --- Private ActiveRecord model
  class Model < ApplicationRecord
    self.table_name = 'people'

    belongs_to :supervisor, class_name: "People::Model", optional: true
    has_many :subordinates, class_name: "People::Model", foreign_key: :supervisor_id

    scope :roots, -> { where(supervisor: nil) }

    def meta
      @meta ||= Meta.new(proto_id, effective_at)
    end

    def meta=(meta)
      self.proto_id = meta.proto_id
      self.effective_at = meta.effective_at

      @meta = meta
    end
  end
  private_constant :Model
end
