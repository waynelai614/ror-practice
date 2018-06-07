StockApiServer::Application.routes.draw do
  get 'board/index.html', to: 'board#index'

  # API routes
  namespace 'api' do
    namespace 'v1' do
      resources :stocks, only: [:index] do
        get 'sort', on: :collection
      end
    end
  end

  root :to => 'board#index'
end
