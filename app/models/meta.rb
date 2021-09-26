class Meta
  attr_reader :proto_id, :effective_at

  def self.new_prototype(effective_date, model_class)
    number_of_events = model_class.where(effective_at: effective_date.beginning_of_day..effective_date.end_of_day).count
    new(SecureRandom.uuid, effective_date.to_date + number_of_events.seconds)
  end

  def self.update_prototype(proto_id, effective_date, model_class)
    number_of_events = model_class.where(effective_at: effective_date.beginning_of_day..effective_date.end_of_day).count
    new(proto_id, effective_date.to_date + number_of_events.seconds)
  end

  private
  attr_writer :proto_id, :effective_at
  attr_accessor :model_class

  def initialize(proto_id, effective_at)
    self.proto_id = proto_id
    self.effective_at = effective_at
  end
end
