class Micropost
  include Postler::Micropost

  def parse
    if (self.text.length > 0)
      identify_hashtags
      identify_user_mentions
    end
  end
end