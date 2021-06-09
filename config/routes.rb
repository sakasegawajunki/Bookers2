Rails.application.routes.draw do

  get '/search' => "search#search"
  get 'favorites/create'
  get 'favorites/destroy'
  root to: "homes#top"
  get "/home/about" =>"homes#about"
  devise_for :users
  resources :users,only: [:show,:edit,:update, :index,] do
   resource :relationships, only: [:create, :destroy]
   get "followings" => "relationships#followings", as: "followings"
   get "followers" => "relationships#followers", as: "followers"
   resources :users, only: [:index, :edit, :update]
 end
   resources :groups, except: [:destroy]
 
  resources :books,only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments,only: [:create, :destroy]
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
