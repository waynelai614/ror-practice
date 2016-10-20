Rails.application.routes.draw do
  get 'top/index'

  resources :turnovers
  get '/crawl', to: 'top#crawl'

  root 'top#index'
end
