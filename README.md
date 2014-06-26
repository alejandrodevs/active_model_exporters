# ActiveModel::Exporters
[![Build Status](https://travis-ci.org/alejandrogutierrez/active_model_exporters.png?branch=master)](https://travis-ci.org/alejandrogutierrez/active_model_exporters) [![Coverage Status](https://coveralls.io/repos/alejandrogutierrez/active_model_exporters/badge.png)](https://coveralls.io/r/alejandrogutierrez/active_model_exporters)

`ActiveModel::Exporters` aims to provide an easy way to export
collections of `ActiveModel` or `ActiveRecord` objects.
It's based on object-oriented development and inspired on
[active_model_serializers](https://github.com/rails-api/active_model_serializers)

## Installation

Add this line to your application's Gemfile:

    gem 'active_model_exporters'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_exporters

## Usage

Generate an exporter in `app/exporters/post_exporter.rb`:
```ruby
class PostExporter < ActiveModel::Exporter
  attributes :id, :name, :email
end
```

In your controller:
```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all

    respond_to do |format|
      format.csv { send_data PostExporter.new(@posts).to_csv }
    end
  end
end
```

When `http://localhost:3000/posts.csv` you will get a file with all
posts in a CSV file.

## Disabling file headers
In the exporter:
```ruby
class PostExporter < ActiveModel::Exporter
  self.headers = false
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
