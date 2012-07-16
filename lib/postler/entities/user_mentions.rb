module Postler
  module Entities
    class UserMentions
      include Mongoid::Document

      field :name, type: String
      field :id_str, type: String
      field :indices, type: Array, default: []

      validates_presence_of :name
    end
  end
end