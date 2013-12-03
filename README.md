# acts_as_gravatar

acts\_as\_gravatar provide simple access to gravatar from ActiveRecord.
From the email columns (can set it optionally) such as devices, acts_as_gravatar generate a URL of gravatar.

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

# get profile url of gravatar.
user.gravatar_profile  # URL of gravatar profile.

# get image url of gravatar.
user.gravatar_image     # URL of gravatar image.

```

acts\_as\_gravatar read `email` column.(default)

### Options
when call acts\_as\_gravatar, can set default values.
(The option not to appoint at the time of acts_as_gravatar summons becomes the default of gravatar.)

```
class User < ActiveRecord::Base
  acts_as_gravatar({
    :column        => :email,                                # email column of Model.
    :default_image => nil,                                   # default_image.(URL or gravatar default image param.)
    :force_default => false,                                 # force the default image.
    :image_type    => ActsAsGravatar::Enums::ImageType::PNG, # image_type. (JPG/JPEG/GIF/PNG)
    :rating        => ActsAsGravatar::Enums::Rating::PG,     # rating. (G/PG/R/X)
    :secure        => false,                                 # secure protocol. (https).
    :size          => 80,                                    # image size.
  })
end
```
Please See [Gravatar](http://ja.gravatar.com/site/implement/), Options of gravatar for more detail.

And can set options, when call `gravatar_image` or `gravatar_profile`.

```
user = User.find(1); #

# get image url of gravatar.
user.gravatar_image :secure => true, :size => 200

# get profile url of gravatar.
user.gravatar_profile :column => :other_column
```


## API DOCUMENT

* [acts_as_gravatar](http://rubydoc.info/github/alfa-jpn/acts_as_gravatar/frames)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# I have poor English. Please help meeeeeeeee!!!!
