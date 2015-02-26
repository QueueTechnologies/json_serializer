require "spec_helper"

class Foo
  include JSONSerializer

  json_attributes :bar
  json_cache_keys :bar

  def bar
    "bar"
  end
end

class FooCollection
  include JSONSerializer

  json_type       :collection
  json_cache_keys :collection_count

  def collection
    [Foo.new]
  end

  def collection_count
    1
  end
end

describe JSONSerializer do
  describe "Instance Methods" do
    describe "#as_json" do
      context "single object" do
        subject { Foo.new }

        it "returns the JSON hash" do
          expect(subject.as_json).to eq({ bar: "bar" })
        end
      end

      context "collection object" do
        subject { FooCollection.new }

        it "returns the JSON array" do
          expect(subject.as_json).to eq([{ bar: "bar" }])
        end
      end
    end
  end

  describe "Class Methods" do
    describe ".json_attributes" do
      subject { Foo.new }

      it "returns the list of attributes of a defined object" do
        expect(subject.attributes).to eq([:bar])
      end
    end

    describe ".json_type" do
      context "when object" do
        subject { Foo.new }

        it "is an object" do
          expect(subject.json_type).to eq(:object)
        end
      end

      context "when collection" do
        subject { FooCollection.new }

        it "is collection" do
          expect(subject.json_type).to eq(:collection)
        end
      end
    end

    describe ".json_cache_keys" do
      let(:cache_key) { Digest::MD5.hexdigest(["bar"].join('-')) }
      subject { Foo.new }

      it "returns the json cache_keys" do
        expect(subject.cache_key).to eq(cache_key)
      end
    end
  end
end
