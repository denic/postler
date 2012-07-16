module Postler
  class EntitiesContainer
    include Mongoid::Document

    embeds_many :hashtags, class_name: "Postler::Entities::Hashtag"
    #embeds_many :user_mention
    #embeds_many :event_mention

  end
end