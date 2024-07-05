Rails.application.routes.draw do
  get 'error_template/index', as: "error"
  devise_for :users

  resources :events do
    resources :guests, only: [:new, :create, :show]
  end
   root "events#index"
end
