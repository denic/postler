module Postler
  module Micropost
    extend ActiveSupport::Concern

    included do

      include Mongoid::Document
      include Mongoid::Timestamps

      field :text, type: String

      #embeds_one :entities, class_name: "Postler::EntitiesContainer"

      embeds_many :hashtags, class_name: "Postler::Entities::Hashtag"
      embeds_many :user_mentions, class_name: "Postler::Entities::UserMentions"
      embeds_many :events, class_name: "Postler::Entities::Event"

      validates_presence_of :text
      validates :text, :length => { :maximum => 140 }

    end

    module ClassMethods
    end

    def identify_user_mentions
      processed_text = ""

      self.text.split(/ /).each do |word|
        if word.match(/^@/)
          user = Postler::Entities::UserMentions.new :name => word
          user.indices << processed_text.length
          user.indices << processed_text.length + word.length - 1 # minus 1 cause we start with 0
          self.user_mentions << user
        end

        processed_text = processed_text + word + " "
      end

      processed_text
    end

    def identify_hashtags
      processed_text = ""

      self.text.split(/ /).each do |word|
        if word.match(/^#/)
          tag = Postler::Entities::Hashtag.new :text => word
          tag.indices << processed_text.length
          tag.indices << processed_text.length + word.length - 1 # minus 1 cause we start with 0
          self.hashtags << tag
        end

        processed_text = processed_text + word + " "
      end

      processed_text
    end

    def identify_events
      processed_text = ""

      self.text.split(/ /).each do |word|
        if word.match(/^\+/)
          ev = Postler::Entities::Event.new :name => word
          ev.indices << processed_text.length
          ev.indices << processed_text.length + word.length - 1 # minus 1 cause we start with 0
          self.events << ev
        end

        processed_text = processed_text + word + " "
      end

      processed_text
    end

  end
end