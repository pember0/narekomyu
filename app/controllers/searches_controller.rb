class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.looks(params[:word])
    # ページャのページ総数の設定追加
    @posts = @posts.page(params[:page]).per(10)
    render 'posts/index'
  end

end
