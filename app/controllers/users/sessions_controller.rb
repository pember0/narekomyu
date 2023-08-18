class Users::SessionsController < Devise::SessionsController
  # ゲストユーザーの設定
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "ゲストユーザーでログインしました。"
  end
end
