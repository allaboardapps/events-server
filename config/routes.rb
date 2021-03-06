Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :user

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root to: "static#home"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "sign_in" => "sessions#create"
      resources :events
      resources :favorites
      resources :locations
      resources :regions
      resources :users
    end
  end
end
