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
    post 'reviews/create'
    post 'cart_items/create'
    delete 'cart_items/destroy'
  end
  resources :categories, only:[:create]
  resources :thumbnails, only:[:create]
  resources :cart_items
  resources :orders 
  resources :personals do
    collection do
      post 'orders/pay'
    end
  end
  resources :reviews, only:[:destroy]
  resources :bodies
  resources :comments
  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  root 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
