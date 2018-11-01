Rails.application.routes.draw do
  get 'stronas/index'
  get 'stronas/pokaz'
  get 'stronas/nowa'
  get 'stronas/edycja'
  get 'stronas/usun'
root "kategories#index"
  # Match wiążę controller, akcje i parametr id i korzystam z metod get i post
  match ':controller(/:action(/:id))', :via => [:get, :post] # rooting domyślny
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
