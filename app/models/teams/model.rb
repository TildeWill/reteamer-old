module Teams
  class Model < ApplicationRecord
    self.table_name = 'teams'
    include MetaModel
  end

  private_constant :Model
end
