class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.looks(params[:word])
    render 'posts/index'
  end

end
