# frozen_string_literal: true

class Link
  SHORT_LINK_LETTERS = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten.freeze
  include ActiveModel::Validations

  attr_accessor :url, :url_title

  validates :url, presence: true, url: true
  
  def self.get(key)
    Marshal.load(REDIS.get(key))
  end
  
  def scrap_title
    GetLinkTitleJob.perform_later(@path_key)
  end
  
  def save_to_redis
    loop do
      @path_key = generate_key
      unless REDIS.exists(@path_key)
        Redis.current.set(@path_key, Marshal.dump(@url))
        break
      end
    end
  end
  
  def persisted?
    Redis.current.exists(@path_key)
  end
  
  def to_key
    @path_key ? @path_key : nil
  end
  
  def process(cookie)
    if cookie
      keys_arr = JSON.parse(cookie)
      url_arr = keys_arr.map{ |key| Link.get(key) }
      url_with_index = url_arr.each_with_index
                              .select{ |url, i| (url == @url) || url.first == @url }
      if url_with_index.present?
        @path_key = keys_arr[url_with_index[0][1]]
      else
        save_to_redis
        keys_arr << @path_key
      end
      keys_arr
    else
      save_to_redis
      scrap_title
      [@path_key]
    end
  end
  
  private

  def generate_key
    SHORT_LINK_LETTERS.sample(8).join
  end
end
