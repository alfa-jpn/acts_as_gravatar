require "acts_as_gravatar/version"
require "acts_as_gravatar/gravatar"
require "active_record"

module ActsAsGravatar
  # Macro for ActiveRecord::Base.
  module Macro
    # Use acts_as_gravatar in model.
    #
    # @example
    #   acts_as_gravatar({
    #     :column        => :email,                                # email column of Model.
    #     :default_image => nil,                                   # default_image.(URL or gravatar default image param.)
    #     :force_default => false,                                 # force the default image.
    #     :image_type    => ActsAsGravatar::Enums::ImageType::PNG, # image_type. (JPG/JPEG/GIF/PNG)
    #     :rating        => ActsAsGravatar::Enums::Rating::PG,     # rating. (G/PG/R/X)
    #     :secure        => false,                                 # secure protocol. (https).
    #     :size          => 80,                                    # image size.
    #   })
    #
    # @params default_options [Hash] Default options of ActsAsGravatar.
    def acts_as_gravatar(default_options = {})
      options = {
        :column        => :email,
        :secure        => false,
        :size          => nil,
        :default_image => nil,
        :rating        => nil,
        :image_type    => nil
      }.merge(default_options)

      include ActsAsGravatar::Methods
      instance_variable_set(:@acts_as_gravatar_default_options, options)
    end
  end

  # Methods of ActiveRecord::Base.
  module Methods

    # Generate a URL of Gravatar image.
    #
    # @example
    #   user = User.find(1)
    #   # get url with default options.
    #   url = user.gravatar_url
    #
    #   # with option.
    #   url = user.gravatar_url {
    #     :column        => :email,                                # email column of Model.
    #     :default_image => nil,                                   # default_image.(URL or gravatar default image param.)
    #     :force_default => false,                                 # force the default image.
    #     :image_type    => ActsAsGravatar::Enums::ImageType::PNG, # image_type. (JPG/JPEG/GIF/PNG)
    #     :rating        => ActsAsGravatar::Enums::Rating::PG,     # rating. (G/PG/R/X)
    #     :secure        => false,                                 # secure protocol. (https).
    #     :size          => 80,                                    # image size.
    #   }
    #
    # @param options [Hash] Option of gravatar image.
    #
    # @return [String] Url of Gravatar image.
    def gravatar_image(options = {})
      opts  = gravatar_option(options)
      email = send(opts[:column])

      ActsAsGravatar::Gravatar.generate_image(email, opts)
    end

    # Generate a URL of Gravatar profile.
    # @example
    #   user = User.find(1)
    #   # get url with default options.
    #   profile = user.gravatar_profile
    #
    #   # with option.
    #   profile = user.gravatar_profile {
    #     :column        => :email
    #   }
    #
    # @param options    [Hash] Option of gravatar profile.
    #
    # @return [String] tag of Gravatar image.
    def gravatar_profile(options = {})
      opts  = gravatar_option(options)
      email = send(opts[:column])

      ActsAsGravatar::Gravatar.generate_profile(email, opts)
    end

    private
    # Get options of gravatar.
    # @note return default options merge merge_options.
    #
    # @param merge_options [Hash] Options of gravatar.
    # @return [Hash] Options of gravatar.
    def gravatar_option(merge_options = {})
      self.class.instance_variable_get(:@acts_as_gravatar_default_options).merge(merge_options)
    end

  end
end

ActiveRecord::Base.send :extend, ActsAsGravatar::Macro
