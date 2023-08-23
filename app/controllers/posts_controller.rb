class PostsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @posts =Post.new
    @user=@post.user
    @comment = Comment.new  # コメント機能用
  end

  def index
    @posts = Post.all
  end

  # 作成データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # バリデーション設定
    if @post.save
      # 新規投稿が成功したとき:フラッシュメッセージ
      flash[:notice] = "You have created post successfully."
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end

  def edit
    # アクセスを制限設定（private以降の行に内容を設定）
    is_matching_login_user
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])    # Postの取得

    # バリデーション設定
    if @post.update(post_params)      # Postのアップデート
      # 投稿の更新が成功したとき:フラッシュメッセージ
      flash[:notice] = "You have updated post successfully."
       redirect_to post_path(@post.id)   # postの詳細ページへのパス
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def tag_search
    tag = Tag.find(params[:id])
    @posts = tag.posts
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :question_content , :tag_id)
  end

  def is_matching_login_user
    post= Post.find(params[:id])
    user= post.user
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end

end
