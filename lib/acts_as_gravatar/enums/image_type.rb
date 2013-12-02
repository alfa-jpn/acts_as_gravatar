require 'inum'

module ActsAsGravatar
  module Enums
    class ImageType < Inum::Base
      define_enum :Jpg
      define_enum :Jpeg
      define_enum :Gif
      define_enum :Png
    end
  end
end