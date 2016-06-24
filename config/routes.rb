Rails.application.routes.draw do

  # root
  root  'welcome#index'

  # static pages
  get  'about'    =>  'welcome#about'
  get  'contact'  =>  'welcome#contact'
  get  'faq'      =>  'welcome#faq'

  # user authentication
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  post 'confirm_user' => 'users#confirm'

  # topics and posts
  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  # post comments, votes & favourites
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  # comments for topics
  resources :topics, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  # advertisements
  resources :advertisements

  # questions
  resources :questions

  # labels
  resources :labels, only: [:show]

  # api
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :topics, only: [:index, :show]
      resources :posts, only: [:index, :show]
      resources :comments, only: [:index, :show]
    end
  end

end
