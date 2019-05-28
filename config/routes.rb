Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  resources :categories
  resources :coordinators
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'course/home'
  get 'course/course_detail'
  get 'course/coordinator_detail'
  get 'course/course_of_category'
  get '/createlocation' , to:'locations#new'
  get '/createcategory' , to:'categories#new'
  get '/createcourse' , to:'courses#new'
  get  '/signup',  to: 'users#new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'course#home'
  
  resources :locations do
    member do
      get :roll 
    end 
  end
 
  resources :courses do 
    member do 
      get  :locations
      post :location_add
      post :location_remove
      post 'vote'
      post 'down_vote'
    end 
  end
  
end
