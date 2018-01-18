Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :users do
  	 resource :trainings, only:[:new,:create,:update,:edit]
     get :inbox, on: :member
     get :inbox_show, on: :member
  end
  resources :items do
    post 'cart_items/create'
    delete 'cart_items/destroy'
  end
  resources :categories, only:[:create]
  resources :thumbnails, only:[:create]
  resources :cart_items
  resources :orders 
  post 'orders/pay'
  resources :bodies
  resources :comments,only:[:new,:create]
  root 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
