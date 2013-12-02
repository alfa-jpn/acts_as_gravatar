require 'spec_helper'

describe ActsAsGravatar::Gravatar do
  before(:each) do
    @params = [
      'nyarukosan@nyaruko.com',
      false,
      200,
      'http://nyaruko.com/',
      ActsAsGravatar::Enums::Rating::PG,
      ActsAsGravatar::Enums::ImageType::Jpg
    ]

    @email_md5    = Digest::MD5.hexdigest(@params[0])
    @url_escaped  = CGI.escape(@params[3])

    @base_url     = "http://www.gravatar.com/avatar/"
    @base_url_ssl = "https://secure.gravatar.com/avatar/"


  end


  it 'generate url.' do
    url = ActsAsGravatar::Gravatar.generate_url(@params[0])

    expect(url).to eq("#{@base_url}#{@email_md5}")
  end

  it 'generate ssl url.' do
    url = ActsAsGravatar::Gravatar.generate_url(@params[0], true)
    expect(url).to eq("#{@base_url_ssl}#{@email_md5}")
  end

  it 'generate url with a size option.' do
    url = ActsAsGravatar::Gravatar.generate_url(*@params[0 .. 2])
    expect(url).to eq("#{@base_url}#{@email_md5}?s=200")
  end

  it 'generate url with a default_image option.' do
    url = ActsAsGravatar::Gravatar.generate_url(@params[0], nil, nil, @params[3])
    expect(url).to eq("#{@base_url}#{@email_md5}?d=#{@url_escaped}")
  end

  it 'generate url with a rating option.' do
    url = ActsAsGravatar::Gravatar.generate_url(@params[0], nil, nil, nil, @params[4])
    expect(url).to eq("#{@base_url}#{@email_md5}?r=pg")
  end

  it 'generate url with a image_type option.' do
    url = ActsAsGravatar::Gravatar.generate_url(@params[0], nil, nil, nil, nil, @params[5])
    expect(url).to eq("#{@base_url}#{@email_md5}.jpg")
  end

  it 'generate url with all options.' do
    url = ActsAsGravatar::Gravatar.generate_url(*@params)
    expect(url).to eq("#{@base_url}#{@email_md5}.jpg?s=200&d=#{@url_escaped}&r=pg")
  end

  it 'generate tag.' do
    tag = ActsAsGravatar::Gravatar.generate_tag(@params[0])
    expect(tag).to eq("<img src=\"#{@base_url}#{@email_md5}\" >")
  end

  it 'generate tag with an attribute.' do
    tag = ActsAsGravatar::Gravatar.generate_tag(@params[0], nil, nil, nil, nil, nil, with:"100px")
    expect(tag).to eq("<img src=\"#{@base_url}#{@email_md5}\" with=\"100px\">")
  end

  it 'generate tag with some attributes.' do
    tag = ActsAsGravatar::Gravatar.generate_tag(@params[0], nil, nil, nil, nil, nil, with:"100px", height:"100px")
    expect(tag).to eq("<img src=\"#{@base_url}#{@email_md5}\" with=\"100px\" height=\"100px\">")
  end
end

