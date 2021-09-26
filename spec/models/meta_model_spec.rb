require 'rails_helper'

describe MetaModel do
  let(:test_model) do Class.new{
      include MetaModel
      attr_accessor :proto_id
      attr_accessor :effective_at
    }
  end

  it "let's a dev set and get the meta information" do
    model = test_model.new
    model.meta = Meta.new("test-proto-id", 22.years.ago.to_date)
    expect(model.proto_id).to eq("test-proto-id")
    expect(model.effective_at).to eq(22.years.ago.to_date)
  end
end
