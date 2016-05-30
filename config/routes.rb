Rails.application.routes.draw do

  root  'welcome#index'

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  post 'confirm_user' => 'users#confirm'

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :advertisements
  resources :questions

  get  'about'    =>  'welcome#about'
  get  'contact'  =>  'welcome#contact'
  get  'faq'      =>  'welcome#faq'

end
