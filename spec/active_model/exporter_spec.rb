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
end
