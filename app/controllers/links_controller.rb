# frozen_string_literal: true

class LinksController < ApplicationController
  def index
    @link = Link.new
  end

  def show
    redirect_to Link.get(params[:short_url])
  end

  def create
    @link = Link.new
    @link.url = permitted_params.fetch(:url)
    session[:path_key] = @link.save.path_key if @link.valid?
    render 'index'
  end
  
  def permitted_params
    params.require(:link).permit(:url)
  end
end
