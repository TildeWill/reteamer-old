module People
  # --- Private ActiveRecord model
  class Model < ApplicationRecord
    self.table_name = 'people'

    belongs_to :manager, class_name: "People::Model", optional: true

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
