Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'auth#login'  # Login endpoint
      post 'register', to: 'users#register'
      get 'roles', to: 'roles#index'
      patch 'users/:id/approve', to: 'users#approve'
      patch 'users/:id/reject', to: 'users#reject'
      get 'pending_approvals', to: 'users#pending_approvals'
      resources :classrooms, only: [:index, :create]
      resources :users, only: [:index] do
        collection do
          get :admin_dashboard_count
        end
      end
    end
  end
end
