Ladder::Application.routes.draw do

  get "contacts/index"
  root to: "pages#home"
  devise_for :players

  # Resources
  resources :players, only: [ :index, :show ]
  resources :matches, only: [ :new, :create, :edit, :update, :destroy ]
  resources :contacts, only: [ :index, :show ]

  # Static Pages
  get 'rules' => 'pages#rules'
  
end
