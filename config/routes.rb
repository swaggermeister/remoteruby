# frozen_string_literal: true

Rails.application.routes.draw do
  # Authentication
  devise_for :employers, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    confirmations: "employers/confirmations",
    passwords: "employers/passwords",
    registrations: "employers/registrations",
    sessions: "employers/sessions",
    unlocks: "employers/unlocks",
  }

  resources :employers

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :job_listings do
    collection do
      # get "search/:search", to: "job_listings#search", as: "search"
      get "my_company", to: "job_listings#my_company", as: "my_company"
    end
  end

  # Home page
  root to: "job_listings#index"
end
