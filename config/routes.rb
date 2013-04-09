VTF::Application.routes.draw do
  devise_for :users

  resources :exercises

  root :to => "landing#index"
end
