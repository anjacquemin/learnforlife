Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :themes, only: [:show, :index]
  resources :subthemes, only: [:show]
  resources :quizz_levels, only: [:show]
  resources :records, only: [:show]
  resources :quizz_answers, only: [:show] do
    resources :user_answers, only:[:create]
    resources :records, only: [:create]
  end

  post "subthemes/:subtheme_id", to: "subthemes#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
