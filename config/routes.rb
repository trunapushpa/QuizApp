Rails.application.routes.draw do
  get 'leaderboard/index'
  resources :questions
  resources :subgenres
  resources :genres
  get '/takequiz', to: 'takequiz#index'
  get '/takequiz/continue', as: 'takequiz_continue'
  post '/takequiz/continue', to:'takequiz#continuepost'
  get '/takequiz/:id', to: 'takequiz#show', as: 'take_quiz_by_id'
  get '/takequiz/:id/:ques', to: 'takequiz#ques', as: 'take_quiz_by_ques'
  post '/takequiz/:id/:ques', to: 'takequiz#next', as: 'take_quiz_by_next'
  post '/takequiz/:id', to: 'takequiz#submit'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'dashboard/index'
  get 'leaderboard', to: 'leaderboard#index'
  post '/leaderboard/getsubgenres', to: 'leaderboard#getsubgenres'
  post '/leaderboard/update', to: 'leaderboard#update'
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
