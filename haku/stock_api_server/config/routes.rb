Rails.application.routes.draw do
  resources :turnovers, only: [:index]
  get '/crawl', to: 'top#crawl'
end
