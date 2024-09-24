Rails.application.routes.draw do
  get "admin" => "admin#index"

  controller :sessions do
    get  "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end
  get "sessions/create"
  get "sessions/destroy"

  resources :users

  resources :products do
    get :who_bought, on: :member
  end

  scope "(:locale)" do
    resources :orders
    resources :line_items
    resources :carts
    root "store#index", as: "store_index", via: :all
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
