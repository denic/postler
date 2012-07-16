module Postler
  module Entities
    class Hashtag
      include Mongoid::Document

      field :text, type: String
      field :indices, type: Array, default: []

      validates_presence_of :text

    end
  end
end

