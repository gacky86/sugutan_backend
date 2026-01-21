Rails.application.routes.draw do
  # ALB用のヘルスチェック
  get '/health', to: ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['OK']] }

  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]
      resources :flashcards do
        resources :cards
      end

      resources :cards do
        resources :extra_notes, only: %i[create index update destroy]
      end

      resources :card_progresses do
        post :start_learning, on: :collection
        collection { get :due }
        member do
          post :review
        end
      end

      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
        sessions: 'api/v1/auth/sessions',
        registrations: 'api/v1/auth/registrations'
        # omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }
      namespace :auth do
        get "validate_token", to: "sessions#validate_token"
      end

      namespace :gemini do
        post 'dictionary', to: 'dictionary#index'
      end

      mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    end
  end
end
