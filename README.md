# Object Mapper in Ruby

Say goodbye to Ruby hash objects 👋

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'object_mapper'
```

## Usage

If you have the plain old Ruby objects below:

```ruby
class Event
  attr_reader :id, :type, :repo, :author, :created_at

  def initialize(id: nil, type: nil, repo: nil, author: nil, created_at: nil)
    @id, @type, @repo, @author, @created_at = id, type, repo, author, created_at
  end
end

class Repo
  attr_reader :id, :name

  def initialize(id: nil, name: nil)
    @id, @name = id, name
  end
end

class Author
  attr_reader :id, :login

  def initialize(id: nil, login: nil)
    @id, @login = id, login
  end
end
```

Then you can convert JSON (or Ruby hashes/arrays) to the Ruby objects above:

```ruby
require 'json'
require 'object_mapper'

data = JSON.parse(<<-DATA, symbolize_names: true)
[
  {
    "id": "12345",
    "type": "New repository created",
    "repo": {
      "id": 3,
      "name": "yuki24/object_mapper"
    },
    "author": {
      "id": 1,
      "login": "yuki24"
    },
    "created_at": "2011-09-06T17:26:27Z"
  }
]
DATA

events = ObjectMapper
            .new(Event => { author: Author, repo: Repo })
            .convert(data, to: Array(Event))

event = fvents.first
event.class        # => Event
event.repo.class   # => Repo
event.author.class # => Author
event.type         # => "New repository created"
event.created_at   # => "2011-09-06T17:26:27Z"
event.repo.name    # => "yuki24/object_mapper"
event.author.login # => "yuki24"
```

## Contributing

1. Fork it (http://github.com/yuki24/object_mapper/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure all tests pass (`bundle exec rake`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request


## License

Copyright (c) 2016 Yuki Nishijima. See MIT-LICENSE for further details.
