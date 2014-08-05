Rails.application.routes.draw do
  mount Piggybak::Engine => '/', as: :piggybak

  devise_for :users

  root 'home#index'
end
