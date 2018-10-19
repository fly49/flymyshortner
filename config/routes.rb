# frozen_string_literal: true

Rails.application.routes.draw do
  root 'links#new'
  get '/:short_url' => 'links#show'
  #post 'create_link' => 'links#create'
  resources :links, only: %i[new show create]
end
