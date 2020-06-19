Rails.application.routes.draw do
  resources :users, path: 'users', only: [:index, :show, :create,:update] do
    member do
      get :booking_history, path: 'booking_history'
      post :update_location, path: 'update_location'
      post :update_availablity, path: 'update_availablity'
    end
  end

  resources :cars, only: [:index, :show, :create,:update], defaults: { format: :json } do
    collection do
      post :register_car_driver, path: "register_car_driver"
    end
  end

  resources :bookings, only: [], defaults: { format: :json } do
    collection do
      post :book_nearest, path: 'book-nearest'
    end
    member do
      post 'end'
    end
  end
end
