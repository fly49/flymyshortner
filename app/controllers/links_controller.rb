# frozen_string_literal: true

class LinksController < ApplicationController
  def index; end

  def show
    redirect_to Link.get(params[:short_url])
  end

  def create
    url = params[:data][:address]
    unless url_valid?(url)
      flash.now[:danger] = I18n.t('link.invalid')
      render 'index' and return
    end
    @link = request.host + '/' + Link.shorten(url)
    render 'index'
  end
end
