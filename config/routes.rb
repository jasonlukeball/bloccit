Rails.application.routes.draw do

  root  'welcome#index'

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
