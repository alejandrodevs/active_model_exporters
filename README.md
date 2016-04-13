# ActiveModel::Exporters
[![Build Status](https://travis-ci.org/alejandrodevs/active_model_exporters.png?branch=master)](https://travis-ci.org/alejandrodevs/active_model_exporters) [![Coverage Status](https://coveralls.io/repos/github/alejandrodevs/active_model_exporters/badge.svg?branch=master)](https://coveralls.io/github/alejandrodevs/active_model_exporters?branch=master)

`ActiveModel::Exporters` aims to provide an easy way to export
collections of `ActiveModel` or `ActiveRecord` objects.
It's based on object-oriented development and inspired on
[active_model_serializers](https://github.com/rails-api/active_model_serializers).

## Installation

Add this line to your Gemfile:
```ruby
gem 'active_model_exporters'
```
Run the bundle command to install it.

## Getting started

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
As `ActiveModel::Serializers` does, you can reject some attributes
according to your business rules:
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

## Contributing

New feature or code refactoring? Submit a pull request that implements it. Don't forget to write your tests and include a CHANGELOG with your updates.

Thank you!


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/alejandrodevs/active_model_exporters/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

