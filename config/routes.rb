Rails.application.routes.draw do
  # ==> Devise routes with custom controllers
  # This will use controllers from app/controllers/users/ instead of Devise's default
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    unlocks: "users/unlocks"
  }

  # ==> Resourceful routes
  resources :employees
  resources :documents

  # ==> Static pages
  get "about" => "pages#about_us"
  get "contact" => "pages#contact_us"
  get "privacy_policy" => "pages#privacy_policy"
  get "terms_conditions" => "pages#terms_conditions"
get "dashboard", to: "pages#dashboard"

  # ==> Root route
  root "home#index"
end

# this is 2nd way of writing the code

# Rails.application.routes.draw do
#   root 'home#index' # for root_path
#
#   get 'about', to: 'pages#about', as: :about
#   get 'contact', to: 'pages#contact', as: :contact
#   get 'privacy-policy', to: 'pages#privacy', as: :privacy_policy
#   get 'terms-and-conditions', to: 'pages#terms', as: :terms_conditions
# end
