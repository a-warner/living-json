require_relative '../lib/living_json.rb'

describe LivingJson do
  let(:json) { LivingJson.new }

  subject { json }
  it { should_not be_nil }
end
