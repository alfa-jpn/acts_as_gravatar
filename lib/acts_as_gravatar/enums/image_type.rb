require 'inum'

module ActsAsGravatar
  module Enums
    class ImageType < Inum::Base
      define_enum :JPG
      define_enum :JPEG
      define_enum :GIF
      define_enum :PNG
    end
  end
end
