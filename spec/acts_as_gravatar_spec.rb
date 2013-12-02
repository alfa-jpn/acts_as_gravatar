require 'spec_helper'

describe ActsAsGravatar do

  before(:each) do
    test_db = 'tmp/test_db'

    File.delete(test_db) if File.exist?(test_db)

    ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => test_db
    ActiveRecord::Base.connection.execute 'CREATE TABLE tests(id integer not null primary key, email string)'
  end

  context 'after acts_as_gravatar,' do
    before(:each) do
      class Test < ActiveRecord::Base
        acts_as_gravatar
        attr_accessor :email

        def initialize
          @email = 'nyarukosan@nyaruko.com'
        end
      end
    end

    it 'gravatar_url exists.' do
      expect(Test.method_defined?(:gravatar_url))
    end

    it 'gravatar_tag exists.' do
      expect(Test.method_defined?(:gravatar_tag))
    end

    context 'instance of ActiveRecord::Base' do
      before(:each) do
        @test_instance = Test.new
      end

      it 'gravatar_url call ActsAsGravatar.generate_url' do
        ActsAsGravatar::Gravatar.should_receive(:generate_url).with('nyarukosan@nyaruko.com', false, nil, nil, nil, nil)
        @test_instance.gravatar_url
      end

      it 'gravatar_tag call ActsAsGravatar.generate_tag' do
        ActsAsGravatar::Gravatar.should_receive(:generate_tag).with('nyarukosan@nyaruko.com', false, nil, nil, nil, nil, {})
        @test_instance.gravatar_tag
      end
    end
  end

  context 'after acts_as_gravatar with options,' do
    before(:each) do
      class Test < ActiveRecord::Base
        acts_as_gravatar({
          :secure         => true,
          :size           => 200,
          :default_image  => 'http://nyaruko.com/',
          :rating         => ActsAsGravatar::Enums::Rating::PG,
          :image_type     => ActsAsGravatar::Enums::ImageType::Gif
        })

        attr_accessor :email

        def initialize
          @email = 'nyarukosan@nyaruko.com'
        end
      end
    end

    context 'instance of ActiveRecord::Base' do
      before(:each) do
        @test_instance = Test.new
      end

      it 'gravatar_url call ActsAsGravatar.generate_url' do
        ActsAsGravatar::Gravatar.should_receive(:generate_url).with(
          'nyarukosan@nyaruko.com',
          true,
          200,
          'http://nyaruko.com/',
          ActsAsGravatar::Enums::Rating::PG,
          ActsAsGravatar::Enums::ImageType::Gif
        )

        @test_instance.gravatar_url
      end

      it 'gravatar_tag call ActsAsGravatar.generate_tag' do
        attributes = {width: "500px"}
        ActsAsGravatar::Gravatar.should_receive(:generate_tag).with(
          'nyarukosan@nyaruko.com',
          true,
          200,
          'http://nyaruko.com/',
          ActsAsGravatar::Enums::Rating::PG,
          ActsAsGravatar::Enums::ImageType::Gif,
          attributes
        )
        @test_instance.gravatar_tag({}, attributes)
      end
    end
  end
end
