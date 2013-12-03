require 'spec_helper'

describe ActsAsGravatar::Gravatar do
  before(:each) do

    #   generate_url 'nyarukosan@nyaruko.com', {
    #     :default_image => nil,                                   # default_image.(URL or gravatar default image param.)
    #     :force_default => false,                                 # force the default image.
    #     :image_type    => ActsAsGravatar::Enums::ImageType::PNG, # image_type. (JPG/JPEG/GIF/PNG)
    #     :rating        => ActsAsGravatar::Enums::Rating::PG,     # rating. (G/PG/R/X)
    #     :secure        => false,                                 # secure protocol. (https).
    #     :size          => 80,                                    # image size.
    #   }

    @email     = 'nyaruratohotepu@nyaruko.com'
    @email_md5 = Digest::MD5.hexdigest(@email)

    @url       = 'http://nyaruko.com/'
    @url_enc   = CGI.escape(@url)

    @options = {
      default_image: @url,
      force_default: true,
      image_type:    ActsAsGravatar::Enums::ImageType::JPG,
      rating:        ActsAsGravatar::Enums::Rating::PG,
      secure:        true,
      size:          200
    }

    @profile_url   = 'http://www.gravatar.com/'
    @image_url     = 'http://www.gravatar.com/avatar/'
    @image_url_ssl = 'https://secure.gravatar.com/avatar/'


  end


  it 'generate_profile generate profile.' do
    url = ActsAsGravatar::Gravatar.generate_profile(@email)
    expect(url).to eq("#{@profile_url}#{@email_md5}")
  end

  it 'generate_profile generate collect profile with disable option.' do
    url = ActsAsGravatar::Gravatar.generate_profile(@email, @options)
    expect(url).to eq("#{@profile_url}#{@email_md5}")
  end

  it 'generate_image generate url.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email)
    expect(url).to eq("#{@image_url}#{@email_md5}")
  end

  it 'generate_image generate collect image with disable option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, aaaaaa: false, bbbbb: 'bbbbbb', null: nil)
    expect(url).to eq("#{@image_url}#{@email_md5}")
  end

  it 'generate_image generate url with a secure option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, secure: true)
    expect(url).to eq("#{@image_url_ssl}#{@email_md5}")
  end

  it 'generate_image generate url with a size option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, size: 200)
    expect(url).to eq("#{@image_url}#{@email_md5}?s=200")
  end

  it 'generate_image generate url with a url defualt_image option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, default_image: @url)
    expect(url).to eq("#{@image_url}#{@email_md5}?d=#{@url_enc}")
  end

  it 'generate_image generate url with a keyword defualt_image option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, default_image: 'mm')
    expect(url).to eq("#{@image_url}#{@email_md5}?d=mm")
  end

  it 'generate_image generate url with a rating option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, rating: ActsAsGravatar::Enums::Rating::PG)
    expect(url).to eq("#{@image_url}#{@email_md5}?r=pg")
  end

  it 'generate_image generate url with a rating option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, image_type: ActsAsGravatar::Enums::ImageType::JPG)
    expect(url).to eq("#{@image_url}#{@email_md5}.jpg")
  end

  it 'generate_image generate url with a force_default option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, force_default: true)
    expect(url).to eq("#{@image_url}#{@email_md5}?f=y")
  end

  it 'generate_image generate url with all option.' do
    url = ActsAsGravatar::Gravatar.generate_image(@email, @options)
    expect(url).to eq("#{@image_url_ssl}#{@email_md5}.jpg?s=200&d=#{@url_enc}&r=pg&f=y")
  end

end

