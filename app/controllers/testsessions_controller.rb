class TestsessionsController < ApplicationController
    # 先にサンプルを作っとくってことか。
    def create
        user=User.find_by(email:"smooth_login@example.com")
        session[:user_id] = user.id
        # log_in(user)
        flash[:success] = "ゲストユーザとしてログインしました！"
        redirect_to root_url
      end
end


# session_helperにあるメソッド
# def log_in(user)
#     session[:user_id] = user.id
#     end