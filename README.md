# ActsAsGravatar

acts\_as\_gravatar provide simple access to gravatar from ActiveRecord.

## Installation

Add this line to your application's Gemfile:

    gem 'acts_as_gravatar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_gravatar

## Usage

### Basic
Call acts\_as\_gravatar in class of ActiveRecord::Base.

```
class User < ActiveRecord::Base
    acts_as_gravatar
end
```

The next method becomes to be usable.

```
user = User.find(1); #

# get html tag of gravatar.
user.gravatar_tag

# get url of gravatar. 
user.gravatar_url

```
acts\_as\_gravatar read `email` column.(default)

### Options
when call acts\_as\_gravatar, can set default values.

```
class User < ActiveRecord::Base
  acts_as_gravatar({
    :column        => :email                            # set email column.
    :secure        => false                             # default protocol. (https).
    :size          => 80                                # default image size.
    :default_image => nil                               # default default_image.
    :rating        => ActsAsGravatar::Enums::Rating     # default rating.
    :image_type    => ActsAsGravatar::Enums::ImageType  # default image_type.
  })
end
```

And can set options, when call `gravatar_tag` or `gravatar_url`.

```
user = User.find(1); #

# get url of gravatar.
user.gravatar_url :secure => true, :size => 200

```

gravatar_tag can set some html attributes.

```
user = User.find(1); #

# get tag of gravatar.
user.gravatar_tag {:secure => true, :size => 200}, {:width => "200px"}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
