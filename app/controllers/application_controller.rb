# frozen_string_literal: true

require 'uri'

class ApplicationController < ActionController::Base
  def url_valid?(url)
    url =~ /\A#{URI.regexp(%w[http https])}\z/
  end
end
