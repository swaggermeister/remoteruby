Rails.application.routes.draw do
  resources :employers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :job_listings do
    collection do
      get "search", to: "job_listings#search"
    end
  end
  root to: "job_listings#index"
end
