Rails.application.routes.draw do

  # resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create, :destroy]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:new, :create, :edit, :update]
  end

	resources :users, controller: "users", only: :show

  resources :addresses do 
    resources :listings, only: [:new, :create]
  end

  resources :listings, only: [:index, :edit, :show, :update, :destroy]

  resources :listings do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:index, :edit, :show, :update, :destroy]

	root 'welcome#index'
  get '/search', to: 'listings#search'

  # get "/current_user/listings", to: "/users/:id/listing"

  get "/sign_in", to: "clearance/sessions#new"
  post "/sign_in", to: "clearance/sessions#create"
  delete "/sign_out", to: "clearance/sessions#destroy"

  get "/sign_up", to: "clearance/users#new"
  # post "/sign_up", to: "clearance/users#create"
  # get "users/show"

	get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # need to check out github for clearance how to generate routes here
  # root "users#index"


	#*** rails g clearance:routes show all these default Clearance routes
	# resources :passwords, controller: "clearance/passwords", only: [:create, :new]
	# resource :session, controller: "clearance/sessions", only: [:create]

	# resources :users, controller: "clearance/users", only: [:create] do
	#   resource :password,
	#     controller: "clearance/passwords",
	#     only: [:create, :edit, :update]
	# end

	# get "/sign_in" => "clearance/sessions#new", as: "sign_in"
	# delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
	# get "/sign_up" => "clearance/users#new", as: "sign_up"
	#*** end of default routes of Clearance
end
