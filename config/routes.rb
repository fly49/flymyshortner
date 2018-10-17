# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'links#index'
  get '/:short_url' => 'links#show'
  post 'create_link' => 'links#create'
  resources :links, only: %i[index show create]
end
