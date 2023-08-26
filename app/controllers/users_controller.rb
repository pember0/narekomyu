class UsersController < ApplicationController
  # before_actionでeditアクション実行前に設定
  before_action :ensure_guest_user, only: [:edit]

  def show
    #データ（レコード）を1件取得
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
    @post = Post.new
  end

  def index
    @user= current_user
    @users = User.where(is_deleted: false)  # 退会していないユーザを全て取得
    @post = Post.new
  end

  def edit
    # アクセスを制限設定（private以降の行に内容を設定）
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    # バリデーション設定
    @user = User.find(params[:id])
    if @user.update(user_params)    # ユーザーのアップデート
      # ユーザーのプロフィール更新が成功したとき:フラッシュメッセージ
      redirect_to user_path(current_user), notice: "ユーザーのプロフィール更新が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)

    flash[:notice] = "退会処理を実行いたしました"
    if current_user.is_administrator && current_user != @user
      redirect_to users_path
    else
      reset_session
      redirect_to root_path
    end
  end

  def likes
    @user = User.find(params[:id])
    @posts = @user.like_posts.order(created_at: :desc).page(params[:page])
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private

  # 作成データのストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # ユーザーの編集画面へのURLを直接入力された場合にはメッセージを表示してユーザー詳細画面へリダイレクト
  def ensure_guest_user
    @user = User.find(params[:id])
    # guest_user?メソッド、メールアドレスがゲストユーザーのものであるかを判定しtrueかfalseの値を返します
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集を利用できません。"
    end
  end

  # 他のユーザーからのアクセスを制限設定
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
