# frozen_string_literal: true

Rails.application.routes.draw do
  root 'links#index'
  get '/:short_url' => 'links#show'
  resources :links, only: %i[show create index]
end
