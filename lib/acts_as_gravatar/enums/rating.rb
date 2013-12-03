require 'inum'

module ActsAsGravatar
  module Enums
    class Rating < Inum::Base
      define_enum :G
      define_enum :PG
      define_enum :R
      define_enum :X
    end
  end
end
