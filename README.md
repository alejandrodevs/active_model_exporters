# ActiveModel::Exporters
[![Build Status](https://travis-ci.com/alejandrodevs/active_model_exporters.svg?branch=master)](https://travis-ci.org/alejandrodevs/active_model_exporters) [![Coverage Status](https://coveralls.io/repos/github/alejandrodevs/active_model_exporters/badge.svg?branch=master)](https://coveralls.io/github/alejandrodevs/active_model_exporters?branch=master)

`ActiveModel::Exporters` aims to provide an easy way to export collections of `ActiveModel` or `ActiveRecord` objects. It's based on object-oriented development and inspired on [active_model_serializers](https://github.com/rails-api/active_model_serializers).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_exporters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_exporters

## Usage

Generate an exporter in `app/exporters/post_exporter.rb`:

```ruby
class PostExporter < ActiveModel::Exporter
  attributes :id, :title, :content
end
```

In your controller:

```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all

    respond_to do |format|
      format.csv { render csv: @posts }
      format.xls { render xls: @posts }
    end
  end
end
```

### Custom exporter

To specify a custom exporter for each object, you can do the next in your controller:

```ruby
render csv: @posts, exporter: OtherPostExporter
```

### Custom filename

By default filename is the pluralized collection type. Example: `posts.xls`.
To specify another, you can do the next:

```ruby
render xls: @posts, filename: 'super_posts.xls'
```

### Custom encode format

By default encode format is `iso-8859-1`. You can change it doing the next:

```ruby
render csv: @posts, encode: 'UTF-8'
```

### Computed properties

As `ActiveModel::Serializers` does, you can access the object being exported as `object`.

```ruby
class UserExporter < ActiveModel::Exporter
  attributes :first_name, :last_name, :full_name

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
```

### Exporter scope

#### 1. Default scope

As `ActiveModel::Serializers` does, you can access to the current user via `scope`.

```ruby
class UserExporter < ActiveModel::Exporter
  attributes :name, :email

  def email
    object.email unless scope.admin?
  end
end
```

#### 2. Explicit scope

In your controller, include the scope option:

```ruby
render csv: @posts, scope: current_admin
```

#### 3. Calling exportation_scope

In your controller, set the exportation scope:

```ruby
class PostsController < ApplicationController
  exportation_scope :current_admin

  def index
    # Do something...
  end
end
```

### Filter attributes

As `ActiveModel::Serializers` does, you can reject some attributes according to your business rules:

```ruby
class UserExporter < ActiveModel::Exporter
  attributes :name, :email, :address

  def filter(attrs)
    if object.admin?
      attrs - [:address]
    else
      attrs
    end
  end
end
```

Rejected attributes will be blank in the downloaded file.

### Headers

`ActiveModel::Exporters` uses I18n translations in file headers.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alejandrodevs/active_model_exporters. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveModel::Exporters project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alejandrodevs/active_model_exporters/blob/master/CODE_OF_CONDUCT.md).
