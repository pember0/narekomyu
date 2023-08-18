Rails.application.routes.draw do
  root to: "homes#top"              # Topページを設定
  devise_for :users

  # ゲストユーザー設定
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # 投稿の設定
  resources :posts, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
    # いいね機能のルーティングを設定
    resource :likes, only: [:create, :destroy]
    # コメント機能のルーティングを設定
    resources :comments, only: [:create, :destroy]
  end

  # 会員の設定
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get 'likes'
    end
    collection do
    end
  end

end
