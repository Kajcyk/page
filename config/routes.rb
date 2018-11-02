Rails.application.routes.draw do
  root "public#index"
  get 'admin', :to => "dostep#index"
  # Match wiążę controller, akcje i parametr id i korzystam z metod get i post
  match ':controller(/:action(/:id))', :via => [:get, :post] # rooting domyślny
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
