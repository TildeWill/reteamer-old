module Assignments
  class Model < ApplicationRecord
    self.table_name = 'assignments'
    include MetaModel
  end

  private_constant :Model
end
