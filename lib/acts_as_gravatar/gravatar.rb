module ActsAsGravatar
  require 'cgi'
  require 'digest/md5'
  require 'acts_as_gravatar/enums/image_type'
  require 'acts_as_gravatar/enums/rating'

  # This class provide some utils of gravatar.
  class Gravatar
    PROFILE_URL   = 'http://www.gravatar.com/'
    IMAGE_URL     = 'http://www.gravatar.com/avatar/'
    IMAGE_URL_SSL = 'https://secure.gravatar.com/avatar/'


    # Generate a URL of Gravatar image.
    #
    # @example
    #   generate_image 'nyarukosan@nyaruko.com', {
    #     :default_image => nil,                                   # default_image.(URL or gravatar default image param.)
    #     :force_default => false,                                 # force the default image.
    #     :image_type    => ActsAsGravatar::Enums::ImageType::PNG, # image_type. (JPG/JPEG/GIF/PNG)
    #     :rating        => ActsAsGravatar::Enums::Rating::PG,     # rating. (G/PG/R/X)
    #     :secure        => false,                                 # secure protocol. (https).
    #     :size          => 80,                                    # image size.
    #   }
    #
    # @param email    [String] Email.
    # @param options  [Hash]   Options of gravatar.
    # 
    # @return [String] Url of Gravatar image.
    def self.generate_image(email, options = {})
      url = generate_image_base_url(email, options)
      opt = generate_image_options(options)

      if opt
        "#{url}?#{opt}"
      else
        url
      end
    end

    # Generate a URL of Gravatar profile.
    #
    # @example
    #   generate_profile 'nyarukosan@nyaruko.com'
    #
    # @param email    [String] Email.
    # @param options  [Hash]   Options of gravatar.(There are none now.)
    #
    # @return [String] Url of Gravatar profile.
    def self.generate_profile(email, options = {})
      generate_profile_base_url(email, options)
    end

    private
    # Generate a base url of Gravatar image.
    #
    # @param email    [String] Email.
    # @param options  [Hash]   Options of gravatar image.
    #
    # @return [String] Url of Gravatar image.
    def self.generate_image_base_url(email, options = {})
      url = []

      if options[:secure]
        url << IMAGE_URL_SSL
      else
        url << IMAGE_URL
      end

      url << Digest::MD5.hexdigest(email.downcase)
      url << ".#{options[:image_type].to_u}" if options[:image_type]

      url.join
    end

    # Generate a options of url.
    #
    # @param options  [Hash]   Options of gravatar image.
    #
    # @return [String] Url of Gravatar image. or nil.
    def self.generate_image_options(options = {})
      opts = []

      opts << "s=#{options[:size]}"                       if options[:size]
      opts << "d=#{CGI.escape(options[:default_image])}"  if options[:default_image]
      opts << "r=#{options[:rating].to_u}"                if options[:rating]
      opts << 'f=y'                                       if options[:force_default]

      if opts.length < 1
        nil
      else
        opts.join('&')
      end
    end

    # Generate a base url of Gravatar profile.
    #
    # @param email    [String] Email.
    # @param options  [Hash]   Options of gravatar profile.
    #
    # @return [String] Url of Gravatar image.
    def self.generate_profile_base_url(email, options = {})
      "#{PROFILE_URL}#{Digest::MD5.hexdigest(email.downcase)}"
    end

  end
end
