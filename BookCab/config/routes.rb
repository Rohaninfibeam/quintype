Rails.application.routes.draw do
  devise_for :drivers, path: 'drivers'
  devise_for :users, path: 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cabs do
  	collection do
  		post :show_cabs
  		get :cabs_index
  	end
  	member do
  		post :update_location
  	end
  end

  resources :bookings do
  	collection do
  		post :show_cabs
  		post :cancel_cab
  		get :get_location
  		post :update_user_location
  	end
  end

  resources :drivers do
  	collection do
  		get :get_user_location
  		post :update_location
  		post :start_ride
  		post :end_ride
  	end
  end
end
