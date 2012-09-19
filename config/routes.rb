Ghjk::Application.routes.draw do

  devise_for :users, :path => "account", :controllers => {
      :registrations => :accounts,
      :sessions => :sessions
  }

  match "articles/last" => "articles#recent", :as => :recent_articles
  resources :articles do
    member do
      #post :reply
      #post :favorite
      #post :follow
      #post :unfollow
      get :reply
    end
    collection do
      #get :no_reply
      #get :popular
      get :hot
      get :recent
      get :video
      get :pic
      # get :reply2
      #get :feed
      #post :preview
    end
    resources :replies
  end

  root :to => 'Home#index'

  match "users", :to => "users#index", :as => :users
  resources :users, :path => "" do
    member do
      get :articles
      get :favorites
    end
  end
end
