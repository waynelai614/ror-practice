class ApplicationController < ActionController::Base
  # used in API-style controllers
  protect_from_forgery with: :null_session
end
