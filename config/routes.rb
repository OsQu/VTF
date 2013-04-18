VTF::Application.routes.draw do
  devise_for :users

  resources :exercises
  resources :sandboxes
  root :to => "landing#index"
end
