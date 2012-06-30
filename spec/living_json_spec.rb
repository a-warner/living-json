require_relative '../lib/living_json.rb'
require_relative 'spec_helper.rb'

describe LivingJson do
  let(:json) { LivingJson.from(input) }
  let(:input) { '{ "baz" : "bing" }' }

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

  context "json with array" do
    let(:input) { '{ "foo" : [2,2,1,5] }' }
    its(:foo) { should == [2,2,1,5] }
  end

  context "get non-existing property" do
    its(:foo) { should be_nil }
  end

  context "setting a non-existing property" do
    before do
      json.foo = "bar"
    end
    its(:foo) { should == "bar" }
  end

  context "iterable" do
    let(:input) { '{ "foo" : "bar", "bar": "baz" }' }
    it { should include("foo") }
    it { should include("bar") }
    it 'should be iterable' do
      json.each do |k, v|
        [k, v]
      end
    end
  end

  context 'allows nested subobjects' do
    let(:input) { '{ "foo": "bar", "col": { "bar": "baz" } }' }
    subject { json.col }
    its(:bar) { should == "baz" }
  end
end
