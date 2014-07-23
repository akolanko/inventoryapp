Inventoryapp::Application.routes.draw do

  root to: "sessions#new"
  post "/" => "sessions#create", as: :new_session
  delete "/" => "sessions#destroy", as: :signout
  resources :users do
  	resources :categories do
  		resources :products do
        resources :sales
        resources :listings
        resources :locations
        resources :tags
      end
      get "/instock" => "categories#instock"
      get "/soldout" => "categories#soldout"
  	end
  	get "/products" => "products#all"
  	get "/instock" => "products#instock"
  	get "/soldout" => "products#soldout"
    get "/listings" => "listings#all"
    get "/listings/search" => "listings#search"
    get "/locations" => "locations#all"
    get "/locations/search" => "locations#search"
    get "/sales" => "sales#all"
    get "/sales/search" => "sales#search"
    get "/tags/search" => "tags#search"
    get "/password" => "users#password"
  end
  resources :password_resets

end
