class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
# コントロールの内容は全部コンソールで実行する時のコマンドなのかな
# new=edit, create=edit。イコールではないけど、機能はほぼ同じ。

  #全てのユーザーを表示する。
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  # 特定のユーザーを表示する
  def show
    @user=User.find(params[:id])
    #正常に処理が行われると、@user=User.find(1)となる。
    @posts = @user.posts.paginate(page: params[:page])
   #これは別にログインしてなくてもよくね？
    # if logged_in?
      # @post  = current_user.posts.build
      @contents_feed = current_user.feed.paginate(page: params[:page])
    # end
  end

  def new
    @user = User.new
  end


  # resources :usersをroutes.rbファイルに追加すると、自動的にRailsアプリケーションが
  # RESTful URI に応答する。/usersへのPOSTリクエストはcreateアクションに送られます。
 


  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email#user.rb
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end





  #ユーザーを見つけるだけ。
  def edit
    @user = User.find(params[:id])
  end

  #ユーザーを更新は、updateを使って送信されたparamsハッシュに基いて行う。createと似ている。
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #成功
      flash[:success]="Updateしました。"
      redirect_to @user
    else
      #失敗
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to users_url
  end

   private


  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  #before edit,update make sure 
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end



end
