Rails.application.routes.draw do
  # resources :tasks
  # resources :projects
  get 'emails/unsubscribe'
  resources :projects do
    resources :tasks
  end  
  # root to: 'static_pages#index'
  
  get   'about', to: 'static_pages#about'
  get   'contact', to: 'static_pages#contact'
  get   'privacy', to: 'static_pages#privacy'
  devise_for :users
  match "users/unsubscribe/:unsubscribe_hash" => "emails#unsubscribe", as: "unsubscribe", via: :all  

  devise_scope :user do 
    authenticated :user do
      root to: "projects#index"
    end

    unauthenticated do
      root to: "home#index", as: :unauthenticated_root
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
