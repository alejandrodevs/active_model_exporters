# frozen_string_literal: true

class UserExporter < ActiveModel::Exporter
  attributes :first_name, :last_name, :full_name

  def full_name
    "#{object.first_name}-#{object.last_name}#{scope ? "-#{scope}" : ""}"
  end
end

class FancyUserExporter < ActiveModel::Exporter
  attributes :first_name, :last_name
end

class FilterUserExporter < ActiveModel::Exporter
  attributes :first_name, :last_name, :email

  def filter(attrs)
    if object.last_name == "Bar1"
      attrs - [:last_name]
    else
      attrs
    end
  end
end
