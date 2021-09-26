module People
  # --- Private ActiveRecord model
  class Model < ApplicationRecord
    self.table_name = 'people'
    include MetaModel

    # belongs_to :supervisor, class_name: "People::Model", optional: true, foreign_key: :supervisor_proto_id

    scope :roots, -> { where(supervisor_id: nil) }
  end
  private_constant :Model
end
