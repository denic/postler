module Postler
  module Entities
    class Event
      include Mongoid::Document

      field :name, type: String
      field :indices, type: Array, default: []

      validates_presence_of :name

    end
  end
end