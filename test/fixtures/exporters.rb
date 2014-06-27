class UserExporter < ActiveModel::Exporter
  attributes :first_name, :last_name, :full_name

  def full_name
    "#{object.first_name}-#{object.last_name}#{scope ? "-#{scope}" : ''}"
  end
end

class FancyUserExporter < ActiveModel::Exporter
  attributes :first_name, :last_name
end
