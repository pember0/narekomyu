Rails.application.routes.draw do
  root to: "homes#top"              # Topページを設定
  devise_for :users

  get 'likes/new'
  get 'likes/create'
  get 'likes/destroy'
  get 'comments/new'
  get 'comments/create'
  get 'comments/destroy'
  get 'posts/new'
  get 'posts/create'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'


  resources :users, only: [:index, :show, :edit, :update]

end
