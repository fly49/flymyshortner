# frozen_string_literal: true

class Link
  class << self
    def shorten(long_link)
      url = shorten_link
      Redis.current.set(url, long_link)
      url
    end

    def get(shorten_link)
      Redis.current.get(shorten_link)
    end

    private

    def shorten_link
      letters = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      (0...8).map { letters[rand(letters.length)] }.join
    end
  end
end
