module People
  # --- Private ActiveRecord model
  class Model < ApplicationRecord
    self.table_name = 'people'

    belongs_to :supervisor, class_name: "People::Model", optional: true
    has_many :subordinates, class_name: "People::Model", foreign_key: :supervisor_id

    scope :roots, -> { where(supervisor: nil) }
    scope :find_for, ->(effective_date) {
          select("DISTINCT proto_id, *")
         .where(effective_at: 30.years.ago..effective_date.end_of_day)
         .order(effective_at: :desc)
    }

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
