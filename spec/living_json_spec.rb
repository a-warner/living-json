require_relative '../lib/living_json.rb'
require_relative 'spec_helper.rb'

describe LivingJson do
  let(:json) { LivingJson.from(input) }

  subject { json }

  context "empty array" do
    let(:input) { "[]" }
    it { should_not be_nil }
  end

  context "empty hash" do
    let(:input) { '{}' }
    it { should_not be_nil }
  end

  context "json with one property" do
    let(:input) { '{ "foo" : "bar" }' }
    its(:foo) { should == "bar" }
  end

  context "json with two properties" do
    let(:input) { '{ "foo": "bar", "jimmy" : "jones" }'}
    its(:foo) { should == "bar" }
    its(:jimmy) { should == "jones" }
  end

  context "changing property" do
    let(:input) { '{ "foo" : "bar" }' }
    before do
      json.foo = "baz"
    end
    its(:foo) { should == "baz" }
  end
end
