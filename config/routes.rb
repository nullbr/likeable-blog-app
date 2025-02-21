Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create] do
        collection do
          get :top_posts
          get :ip_authors
          post :rate
        end
      end
    end
  end
end
