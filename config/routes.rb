Rails.application.routes.draw do

  # root
  root  'welcome#index'

  # static pages
  get  'about'    =>  'welcome#about'
  get  'contact'  =>  'welcome#contact'
  get  'faq'      =>  'welcome#faq'

  # user authentication
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  post 'confirm_user' => 'users#confirm'

  # topics and posts
  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  # comments for posts
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  # advertisements
  resources :advertisements

  # questions
  resources :questions

end
