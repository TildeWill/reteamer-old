module Connections
  class Model < ApplicationRecord
    self.table_name = 'connections'
    include MetaModel

    def self.find_for(effective_date)
      self
        .where(
          effective_at: 30.years.ago..effective_date.end_of_day,
        )
        .order(effective_at: :desc)
        .group_by(&:proto_id)
        .map{|_, models| models.first}
        .select{ |model| model.active? }
    end
  end

  # private_constant :Model
end
