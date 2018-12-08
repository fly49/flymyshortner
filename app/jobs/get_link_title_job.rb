# frozen_string_literal: true
require 'httparty'

class GetLinkTitleJob < ActiveJob::Base
  queue_as :default

  def perform(path_key)
    url = Link.get(path_key)
    content_type = HTTParty.head(url).headers['content-type']
    return unless content_type.include? 'text/html'
    page_conent = HTTParty.get(url).body
    title = page_conent.scan(/<title>\s*(.+)<\/title>$/).flatten.first
    if title
      url_title = CGI::unescapeHTML(title)
      Redis.current.set(path_key, Marshal.dump([url,url_title]))
    end
  end
end
