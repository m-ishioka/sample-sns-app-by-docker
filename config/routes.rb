Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :comments
  resources :sessions

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    root to: 'posts#index'
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end

  get '/404', controller: 'application', action: 'render_404'
  get '*path', controller: 'application', action: 'render_404'
end
