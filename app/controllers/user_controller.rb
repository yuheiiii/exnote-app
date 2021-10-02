class UserController < ApplicationController

 before_action :authenticate_user, {only: [:show]}
 before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def new
  end

 def create
        @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
      )
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to("/room/index")
      else
        @errormessage = "入力内容に重複または空欄があります"
        render("user/new")
      end
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if @user.save
      flash[:notice] = "情報を編集しました"
   else
      render("user/edit")
   end
 end

 def login_form
 end

 def login
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    flash[:notice]="ログインしました"
    session[:user_id] = @user.id
    redirect_to("/room/index")
  else
    @errormessage = "メールアドレスまたはパスワードが間違っています"
    render("user/login_form")
  end
 end

 def logout
  session[:user_id] = nil
  flash[:notice] ="ログアウトしました"
  redirect_to("/")
 end

 def user_params
  params.require(:user).permit(:name, :email, :password)
end

end
