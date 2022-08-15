# frozen_string_literal: true

class User
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :last_name, :string
  attribute :first_name, :string
end
