Rails.application.routes.draw do
  resources :employers do
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :job_listings do
    collection do
      get "search", to: "job_listings#search"
      get "my_company", to: "job_listings#my_company", as: "my_company"
    end
  end
  get "login", to: "authentication#login_form"
  root to: "job_listings#index"
end
