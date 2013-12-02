require "acts_as_gravatar/version"
require "acts_as_gravatar/gravatar"
require "active_record"

module ActsAsGravatar
  # Macro for ActiveRecord::Base.
  module Macro
    # Use acts_as_gravatar in model.
    #
    # @example
    #   acts_as_gravatar {
    #     :column        => :email                            # email column.
    #     :secure        => false                             # default protocol. (https).
    #     :size          => 80                                # default image size.
    #     :default_image => nil                               # default default_image.
    #     :rating        => ActsAsGravatar::Enums::Rating     # default rating.
    #     :image_type    => ActsAsGravatar::Enums::ImageType  # default image_type.
    #   }
    #
    # @params params [Hash] Options of ActsAsGravatar.
    def acts_as_gravatar(params = {})
      options = {
        :column        => :email,
        :secure        => false,
        :size          => nil,
        :default_image => nil,
        :rating        => nil,
        :image_type    => nil
      }.merge(params)

      include ActsAsGravatar::Methods
      instance_variable_set(:@acts_as_gravatar_params, options)
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
    #     :secure        => false                             # default protocol. (https).
    #     :size          => 80                                # default image size.
    #     :default_image => nil                               # default default_image.
    #     :rating        => ActsAsGravatar::Enums::Rating     # default rating.
    #     :image_type    => ActsAsGravatar::Enums::ImageType  # default image_type.
    #   }
    #
    # @param options [Hash] Option of gravatar.
    #
    # @return [String] Url of Gravatar image.
    def gravatar_url(options={})
      opt   = self.class.instance_variable_get(:@acts_as_gravatar_params).merge(options)
      email = send(opt[:column])

      ActsAsGravatar::Gravatar.generate_url(
        email, opt[:secure], opt[:size], opt[:default_image], opt[:rating], opt[:image_type]
      )
    end

    # Generate a tag of Gravatar image.
    # @example
    #   user = User.find(1)
    #   # get url with default options.
    #   tag = user.gravatar_tag
    #
    #   # with option.
    #   tag = user.gravatar_tag {
    #     :secure        => false                             # default protocol. (https).
    #     :size          => 80                                # default image size.
    #     :default_image => nil                               # default default_image.
    #     :rating        => ActsAsGravatar::Enums::Rating     # default rating.
    #     :image_type    => ActsAsGravatar::Enums::ImageType  # default image_type.
    #   }
    #
    #   # with attributes of tag.
    #   tag = user.gravatar_tag {},{
    #     width: "100px",
    #     height: "100px"
    #   }
    #
    # @param options    [Hash] Option of gravatar.
    # @param attributes [Hash] Attributes of tag.
    #
    # @return [String] tag of Gravatar image.
    def gravatar_tag(options={}, attributes={})
      opt   = self.class.instance_variable_get(:@acts_as_gravatar_params).merge(options)
      email = send(opt[:column])

      ActsAsGravatar::Gravatar.generate_tag(
        email, opt[:secure], opt[:size], opt[:default_image], opt[:rating], opt[:image_type], attributes
      )
    end

  end
end

ActiveRecord::Base.send :extend, ActsAsGravatar::Macro
