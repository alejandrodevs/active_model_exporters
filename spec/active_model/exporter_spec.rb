require 'spec_helper'

describe ActiveModel::Exporter do
  describe '.attributes' do
    it '_attributes is not the same for exporters' do
      expect(PostExporter._attributes).to_not equal(UserExporter._attributes)
    end

    context 'when pass single param' do
      it 'stores attribute in _attributes' do
        PostExporter.attributes :name
        expect(PostExporter._attributes).to include(:name)
      end
    end

    context 'when pass multiple params' do
      it 'stores attributes in _attributes' do
        PostExporter.attributes :name, :email, :phone
        expect(PostExporter._attributes).to include(:name, :email, :phone)
      end
    end
  end

  describe '.headers' do
    it 'is an _headers class method alias' do
      expect(PostExporter.method(:headers)).to eq(PostExporter.method(:_headers))
    end
  end

  describe 'initializer' do
    it 'assings collection to an accessor' do
      collection = [1, 2, 3, 4]
      exporter = PostExporter.new(collection)
      expect(exporter.collection).to eq collection
    end
  end
end
