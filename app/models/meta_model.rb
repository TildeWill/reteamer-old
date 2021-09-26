module MetaModel
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def find_for(effective_date)
      self
        .where(
          effective_at: ..effective_date.end_of_day,
        )
        .order(effective_at: :desc)
        .group_by(&:proto_id)
        .map{|_, models| models.first}
        .select{ |model| model.active? }
    end
  end

  def meta
    @meta ||= Meta.new(proto_id, effective_at)
  end

  def meta=(meta)
    self.proto_id = meta.proto_id
    self.effective_at = meta.effective_at

    @meta = meta
  end
end
