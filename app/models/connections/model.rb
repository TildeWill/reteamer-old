module Connections
  class Model < ApplicationRecord
    self.table_name = 'connections'
    include MetaModel
  end

  private_constant :Model
end
