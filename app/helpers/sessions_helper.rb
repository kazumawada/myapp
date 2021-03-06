module SessionsHelper

def log_in(user)
session[:user_id] = user.id
end

def current_user
  if session[:user_id]
    #find_byでnillが返ってくれるから、例外がない。
    @current_user ||= User.find_by(id: session[:user_id])
  end
  #  if (user_id = session[:user_id])
  #    @current_user ||= User.find_by(id: user_id)
  #  elsif (user_id = cookies.signed[:user_id])
  #    user = User.find_by(id: user_id)
  #                    #user.rb
  #    if user && user.authenticated?(cookies[:remember_token])
  #      log_in user
  #      @current_user = user
  #    end
  #  end
 end

 #if its current_user → true.
 def current_user?(user)
  #  user && user==current_user
  user == current_user
 end

 #current_userがnillじゃなければ(!)trueを返す。=current_userがいればtrueを返す。
 def logged_in?
    !current_user.nil?
 end

 def log_out
    #log_inメソッドで作ったIDを削除する。
    session.delete(:user_id)
    #リクエストが来たら。nillにする。
    @current_user = nil
 end

 # 記憶したURL（もしくはデフォルト値）にリダイレクト
 def redirect_back_or(default)
   redirect_to(session[:forwarding_url] || default)
   session.delete(:forwarding_url)
 end

 # アクセスしようとしたURLを覚えておく
 def store_location
   session[:forwarding_url] = request.original_url if request.get?
 end

end
