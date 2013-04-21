VTF::Application.routes.draw do
  devise_for :users

  resources :exercises do
    resource :sandbox
  end

  root :to => "landing#index"
end
