require_relative '../lib/living_json.rb'
require_relative 'spec_helper.rb'

describe LivingJson do
  let(:json) { LivingJson.from(input) }
  let(:input_with_one_prop) { {'foo' => 'bar'} }
  let(:input) { input_with_one_prop  }

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
    its(:foo) { should == "bar" }
  end

  context "json with two properties" do
    before { input['jimmy'] = 'jones' }
    its(:foo) { should == "bar" }
    its(:jimmy) { should == "jones" }
  end

  context "changing property" do
    before { json.foo = "baz" }
    its(:foo) { should == "baz" }
  end

  context "json with array" do
    let(:input) { { "foo" => [2,2,1,5] } }
    its(:foo) { should == [2,2,1,5] }
  end

  context "get non-existing property" do
    its(:baz) { should be_nil }
  end

  context "setting a non-existing property" do
    before { json.new_prop = "bar" }
    its(:new_prop) { should == "bar" }
  end

  context "iterable" do
    let(:input) { { "foo" => "bar", "bar" => "baz" } }
    it { should include("foo") }
    it { should include("bar") }
  end

  context 'allows nested subobjects' do
    before { input['col'] = { "bar" => "baz" } }
    subject { json.col }
    its(:bar) { should == "baz" }
  end

  context 'parses json if input is a string' do
    let(:input) { '{"hello" : "world"}' }
    its(:hello) { should == "world" }
  end

  context 'multiple json entities' do
    let(:other_json) { LivingJson.from "foo" => "not bar" }
    before do
      other_json.foo
    end
    its(:foo) { should == "bar" }
  end
end
