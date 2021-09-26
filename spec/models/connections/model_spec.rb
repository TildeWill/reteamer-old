require 'rails_helper'

describe Connections::Model do
  it "let's a dev set and get the meta information" do
    model = Connections::Model.new
    model.meta = Meta.new("test-proto-id", 22.years.ago.to_date)
    expect(model.proto_id).to eq("test-proto-id")
    expect(model.effective_at).to eq(22.years.ago.to_date)
  end
end
