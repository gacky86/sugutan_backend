Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        omniauth_callbacks: 'api/v1/omniauth_callbacks'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end
      mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    end
  end
end
