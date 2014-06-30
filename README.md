# ActiveModel::Exporters
[![Build Status](https://travis-ci.org/alejandrogutierrez/active_model_exporters.png?branch=master)](https://travis-ci.org/alejandrogutierrez/active_model_exporters) [![Coverage Status](https://coveralls.io/repos/alejandrogutierrez/active_model_exporters/badge.png)](https://coveralls.io/r/alejandrogutierrez/active_model_exporters)

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
    end
  end
end
```

Or:
```ruby
class PostsController < ApplicationController
  respond_to :csv

  def index
    @posts = Post.all
    respond_with @posts
  end
end
```

### Custom exporter
To specify a custom exporter for an object, you can do the next in your controller:
```ruby
render csv: @posts, exporter: OtherPostExporter
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
As `ActiveModel::Serializers` does, you can access to the current user application via `scope`.
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
render csv: @posts, scope: :current_admin
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


## Contributing

New feature or code refactoring? Submit a pull request that implements it. Don't forget to write your tests and include a CHANGELOG with your updates.

Thank you :heart:
