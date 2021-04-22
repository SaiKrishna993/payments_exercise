Rails.application.routes.draw do
  constraints format: :json do
    resources :loans, only: [:index, :show] do
      resources :payments, only: [:index, :create]
    end

    resources :payments, only: [:show]
  end
end
