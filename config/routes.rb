Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]
      resources :flashcards do
        resources :cards
      end

      resources :cards do
        resources :extra_notes, only: %i[create index update destroy]
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
