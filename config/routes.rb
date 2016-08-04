Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:create, :new, :destroy]

  resources :bands do
    resources :albums, on: :member, only: [:new]
  end

  resources :albums, except: [:new] do
    resources :tracks, on: :member, only: [:new]
  end

  resources :tracks,  except: [:new] do
    resources :notes, on: :member, only: [:new, :create]
  end

  resources :notes, only: [:destroy, :update, :edit]
end
