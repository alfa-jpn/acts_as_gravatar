require 'spec_helper'

describe ActsAsGravatar do

  before(:each) do
    test_db = 'tmp/test_db'

    File.delete(test_db) if File.exist?(test_db)

    ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => test_db
    ActiveRecord::Base.connection.execute 'CREATE TABLE tests(id integer not null primary key, email string)'

    @default_option ={
        :column=>:email,
        :secure=>false,
        :size=>nil,
        :default_image=>nil,
        :rating=>nil,
        :image_type=>nil
    }
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

    it 'gravatar_image exists.' do
      expect(Test.method_defined?(:gravatar_image))
    end

    it 'gravatar_profile exists.' do
      expect(Test.method_defined?(:gravatar_profile))
    end

    context 'instance of ActiveRecord::Base' do
      before(:each) do
        @test_instance = Test.new
      end

      it 'gravatar_image call ActsAsGravatar.generate_image' do
        ActsAsGravatar::Gravatar.should_receive(:generate_image).with('nyarukosan@nyaruko.com', @default_option)
        @test_instance.gravatar_image
      end

      it 'gravatar_profile call ActsAsGravatar.generate_profile' do
        ActsAsGravatar::Gravatar.should_receive(:generate_profile).with('nyarukosan@nyaruko.com', @default_option)
        @test_instance.gravatar_profile
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
          :image_type     => ActsAsGravatar::Enums::ImageType::GIF
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

      it 'gravatar_url call ActsAsGravatar.generate_image' do
        ActsAsGravatar::Gravatar.should_receive(:generate_image).with(
          "nyarukosan@nyaruko.com",
          {
            :column         => :email,
            :secure         => true,
            :size           => 200,
            :default_image  => 'http://nyaruko.com/',
            :rating         => ActsAsGravatar::Enums::Rating::PG,
            :image_type     => ActsAsGravatar::Enums::ImageType::GIF
          }
        )
        @test_instance.gravatar_image
      end

      it 'gravatar_image call ActsAsGravatar.generate_image with merged option.' do
        ActsAsGravatar::Gravatar.should_receive(:generate_image).with(
            "nyarukosan@nyaruko.com",
            {
                :column         => :email,
                :secure         => true,
                :size           => 200,
                :default_image  => 'mm',
                :rating         => ActsAsGravatar::Enums::Rating::PG,
                :image_type     => ActsAsGravatar::Enums::ImageType::GIF
            }
        )
        @test_instance.gravatar_image :default_image => 'mm'
      end

      it 'gravatar_profile call ActsAsGravatar.generate_profile' do
        ActsAsGravatar::Gravatar.should_receive(:generate_profile).with(
          "nyarukosan@nyaruko.com",
          {
            :column         => :email,
            :secure         => true,
            :size           => 200,
            :default_image  => 'http://nyaruko.com/',
            :rating         => ActsAsGravatar::Enums::Rating::PG,
            :image_type     => ActsAsGravatar::Enums::ImageType::GIF
          }
        )
        @test_instance.gravatar_profile
      end

      it 'gravatar_profile call ActsAsGravatar.generate_profile with merged option.' do
        ActsAsGravatar::Gravatar.should_receive(:generate_profile).with(
            "nyarukosan@nyaruko.com",
            {
                :column         => :email,
                :secure         => false,
                :size           => 888,
                :default_image  => 'http://nyaruko.com/',
                :rating         => ActsAsGravatar::Enums::Rating::PG,
                :image_type     => ActsAsGravatar::Enums::ImageType::GIF
            }
        )
        @test_instance.gravatar_profile :secure => false, :size => 888
      end
    end
  end
end
