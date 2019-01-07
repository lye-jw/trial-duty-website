Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'registrations' }

  root to: 'duties#index'

  # users
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: :user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  patch '/users/:id/edit', to: 'users#update', as: :password
  put '/users/:id/edit', to: 'users#update'
  
  # duties
  resources :duties, only: [:index] do
    collection do
      post 'generate', to: 'duties#generate_duties'
      post 'open_drop_modal', to: 'duties#open_drop_modal'
      post 'open_grab_modal', to: 'duties#open_grab_modal'
      post 'grab', to: 'duties#grab'
      post 'drop', to: 'duties#drop'
    end
  end

  # announcements
  resources :announcements, only: %i[index create destroy update]

  # availabilities schedule
  resources :availabilities, only: [:index] do
    collection do
      patch '/', to: 'availabilities#update_availabilities'
      put '/', to: 'availabilities#update_availabilities'
      get '/show_everyone', to: 'availabilities#show_everyone'
    end
  end

  namespace :availabilities do
    resources :places, only: %i[index edit update]
  end

  # guide
  get 'guide', to: 'static_pages#guide'

  # grab duty
  get 'grab_duty', to: 'duties#show_grabable_duties'

  # problem reports
  resources :problem_reports, only: %i[index create new update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
