# frozen_string_literal: true

class Link
  SHORT_LINK_LETTERS = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten.freeze
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :url
  attr_reader :path_key

  validates :url, presence: true, url: true
  
  def self.get(shorten_link)
    Redis.current.get(shorten_link)
  end
  
  def initialize
    @path_key = shorten_path
  end
  
  def save
    persisted? ? Link.get(@path_key) : Redis.current.set(@path_key, @url)
    return self
  end
  
  def persisted?
    Redis.current.exists(@path_key)
  end

  private

  def shorten_path
    (0...8).map { SHORT_LINK_LETTERS[rand(SHORT_LINK_LETTERS.length)] }.join
  end
end
