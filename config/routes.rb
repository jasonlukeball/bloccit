Rails.application.routes.draw do

  root  'welcome#index'

  resources :posts

  get  'about'    =>  'welcome#about'
  get  'contact'  =>  'welcome#contact'
  get  'faq'      =>  'welcome#faq'

end
