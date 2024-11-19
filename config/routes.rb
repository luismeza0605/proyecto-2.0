Rails.application.routes.draw do
  root 'welcome#index'  # Página principal
  devise_for :users     # Rutas de Devise para autenticación
  resources :articles do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  # Rutas adicionales para la aplicación
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
