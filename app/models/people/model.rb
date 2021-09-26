module People
  # --- Private ActiveRecord model
  class Model < ApplicationRecord
    self.table_name = 'people'
    include MetaModel

    scope :roots, -> { where(supervisor_id: nil) }
  end
  private_constant :Model
end
