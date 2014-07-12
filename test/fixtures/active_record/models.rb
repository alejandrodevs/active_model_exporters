require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :ar_users, force: true do |t|
    t.string     :first_name
    t.string     :last_name
    t.timestamps
  end
end

class ARUser < ActiveRecord::Base
end
