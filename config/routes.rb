require 'api_constraints'

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users#, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  root to: "home#index"
  
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    
    resources :transactions
    end
  end
  
 resources :transactions do
    get   'search', on: :collection
    get   'events', on: :collection
    get   'memberships', on: :collection
    get   'donations', on: :collection
    post  'search_date' , on: :collection
    post  'export_excel', on: :collection
    get   'metrics', on: :collection
  end
  
end
