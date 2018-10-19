# frozen_string_literal: true

class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def show
    redirect_to Link.get(params[:short_url])
  end

  def create
    @link = Link.new
    @link.url = permitted_params.fetch(:url)
    if @link.valid?
      @link.save
      render 'new'
    else
      render 'new' and return
    end
  end
  
  def permitted_params
    params.require(:link).permit(:url)
  end
end
