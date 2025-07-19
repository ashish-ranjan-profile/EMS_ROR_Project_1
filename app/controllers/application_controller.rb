class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Skip login check for Devise pages like sign in, sign up, etc.
  before_action :authenticate_user!, unless: :devise_controller?

  allow_browser versions: :modern
end
