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
    if @link.valid?
      @link.save
      session[:path_key] = @link.to_key.first
    else
      flash[:danger] = I18n.t('link.invalid')
    end
    redirect_to root_path
  end
  
  def permitted_params
    params.require(:link).permit(:url)
  end
end
