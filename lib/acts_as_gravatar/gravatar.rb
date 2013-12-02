module ActsAsGravatar
  require 'cgi'
  require 'digest/md5'
  require 'acts_as_gravatar/enums/image_type'
  require 'acts_as_gravatar/enums/rating'

  # This class provide some utils of gravatar.
  class Gravatar
    URL='http://www.gravatar.com/avatar/'
    URL_SSL='https://secure.gravatar.com/avatar/'

    # Generate a URL of Gravatar image.
    # @If use a default of gravatar(without email), set nil.
    #
    # @param email          [String]  Email.
    # @param secure         [Boolean] Use SSL?
    # @param size           [Integer] Size of Icon.
    # @param default_image  [String]  Url of default image.
    # @param rating         [ActsAsGravatar::Enums::Rating] Rating of image.
    # @param image_type     [ActsAsGravatar::Enums::ImageType] Type of image.
    # 
    # @return [String] Url of Gravatar image.
    def self.generate_url(email, secure=false, size=nil, default_image=nil, rating=nil, image_type=nil)
      url = generate_base_url(email, secure, image_type)
      opt = generate_options_url(size, default_image, rating)

      if opt
        "#{url}?#{opt}"
      else
        url
      end
    end

    # Generate a tag of Gravatar image.
    # @If use a default of gravatar(without email), set nil.
    #
    # @param email          [String]  Email.
    # @param secure         [Boolean] Use SSL?
    # @param size           [Integer] Size of Icon.
    # @param default_image  [String]  Url of default image.
    # @param rating         [ActsAsGravatar::Enums::Rating] Rating of image.
    # @param image_type     [ActsAsGravatar::Enums::ImageType] Type of image.
    # @param option         [Hash] option of attribute.
    #
    # @return [String] Url of Gravatar image.
    def self.generate_tag(email, secure=false, size=nil, default_image=nil, rating=nil, image_type=nil, option={})
      attrs = []
      image = generate_url(email, secure, size, default_image, rating, image_type)
      option.each do |key, value|
        attrs << "#{key}=\"#{value}\""
      end

      "<img src=\"#{image}\" #{attrs.join(' ')}>"
    end

    private
    # Generate a base url of Gravatar image.
    #
    # @param email          [String]  Email.
    # @param secure         [Boolean] Use SSL?
    # @param image_type     [ActsAsGravatar::Enums::ImageType] Type of image.
    #
    # @return [String] Url of Gravatar image.
    def self.generate_base_url(email, secure, image_type)
      url = []

      if secure
        url << URL_SSL
      else
        url << URL
      end

      url << Digest::MD5.hexdigest(email.downcase)

      url << ".#{image_type.to_u}" if image_type

      url.join
    end

    # Generate a options of url.
    #
    # @param size           [Integer] Size of Icon.
    # @param default_image  [String]  Url of default image.
    # @param rating         [ActsAsGravatar::Enums::Rating] Rating of image.
    #
    # @return [String] Url of Gravatar image. or nil.
    def self.generate_options_url(size=nil, default_image=nil, rating=nil)
      opts = []

      opts << "s=#{size}"                       if size
      opts << "d=#{CGI.escape(default_image)}"  if default_image
      opts << "r=#{rating.to_u}"                if rating

      if opts.length < 1
        nil
      else
        opts.join('&')
      end
    end
  end
end
