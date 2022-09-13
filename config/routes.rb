Rails.application.routes.draw do
  get root to: "pages#home"
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions",}


  resources :themes, only: [:show, :index] do
    resources :flashcards, only: [:index]
  end
  resources :flashcards, only: [:update]
  resources :subthemes, only: [:show]
  resources :quizz_levels, only: [:show]
  resources :records, only: [:show]
  resources :quizz_answers, only: [:show] do
    resources :user_answers, only:[:create]
    resources :records, only: [:create]
  end

  resources :characters, only: [:update]

  # post "subtheme/:subtheme_id", to: "subthemes#show"
  get "theme/:theme_id/flashcards/results", to: "flashcards#results"
  get "theme/:theme_id/flashcards/:learn_or_revise", to: "flashcards#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
