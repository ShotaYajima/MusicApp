class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user #編集する人がログインしている人と正しいか
    if @current_user.id =! params[:id].to_i #to_iメソッドを用いて、文字列を数値に変換
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create            
    @user = User.new(
      name: params[:name], 
      user_name: params[:user_name],
      image_name: "default_user.jpg",
      password: params[:password]
    )            
    if @user.save 
      session[:user_id]= @user.id
      flash[:notice] = "ユーザー登録が完了しました"           
      redirect_to("/users/#{@user.id}")         
    else
      render("users/new", status: :unprocessable_entity)
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.user_name = params[:user_name]

    if params[:image] #画像が保存されたときに作動する
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image] #updateアクションで、フォームから送信された画像データをparamsから取得
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end


    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit", status: :unprocessable_entity)
    end
  end

  def login_form

  end

  def login
    @user = User.find_by(user_name: params[:user_name],
                        password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message= "ユーザーネームまたはパスワードが間違っています"
      @user_name= params[:user_name]
      @password= params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user 
    if @current_user.id != params[:id].to_i #to_iメソッドを用いて、文字列を数値に変換
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
