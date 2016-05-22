Rails.application.routes.draw do

  root  'welcome#index'

  resources :posts
  resources :advertisements

  get  'about'    =>  'welcome#about'
  get  'contact'  =>  'welcome#contact'
  get  'faq'      =>  'welcome#faq'

end
