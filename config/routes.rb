Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  root 'welcome#index'

  get '/how-it-works' => 'pages#how_it_works'
  get '/about-us' => 'pages#about_us'
  get '/faq' => 'pages#faq'
  get '/our-writers' => 'pages#our_writers'
  get '/contact-us' => 'pages#contact_us'
  get 'orders/:public_id/step-two' => 'orders#step_two', as: 'step_two'
  get 'orders/:public_id/step-three' => 'orders#step_three', as: 'step_three'
  get 'orders/calculate_order' => 'orders#calculate_order', as: 'calculate'
  get 'success/:id' => 'orders#success', as: 'success'
  get 'resources/upload/:id' => 'resources#upload', as: 'upload'
  get 'my-orders' => 'users#orders', as: 'orders_list'
  get 'paypal/express_checkout/:id' => 'paypal#checkout', as: 'express_checkout'
  get 'paypal/:id/get_token' => 'paypal#get_token', as: 'get_token'
  post 'user/sign_in_or_sign_up' => 'users#sign_up_or_sign_in', as: 'registration_or_login'

  resources :orders

  resources :resources

end
