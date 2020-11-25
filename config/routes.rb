Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  resources :employers do
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :job_listings do
    collection do
      #get "search/:search", to: "job_listings#search", as: "search"
      get "my_company", to: "job_listings#my_company", as: "my_company"
    end
  end

  root to: "job_listings#index"
end
