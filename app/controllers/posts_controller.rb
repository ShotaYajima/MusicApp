class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}


  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id]) #投稿されたidを取得する
    @user = @post.user #user_idカラムの値から、そのユーザーの情報を取得する
  end

  def new #新規投稿用
    @post = Post.new
  end

  def create #書き込まれた内容を保存する
    @post = Post.new(
      content: params[:content],
      artist_title: params[:artist_title],
      image_url: params[:image].tempfile.path,
      user_id: @current_user.id,      
    ) #contentが入力データのインスタンスを作成してる
    

    if params[:image].present? # 画像が送信された場合の処理
      uploaded_image = params[:image]
      image_filename = "#{Time.now.to_i}_#{uploaded_image.original_filename}" # 一意のファイル名を生成する
      image_path = Rails.root.join('public', 'post_images', image_filename) # 保存先のパスを設定する
  
      # ファイルを保存する
      File.open(image_path, 'wb') do |file|
        file.write(uploaded_image.read)
      end
  
      @post.image_url = image_filename # 画像のファイル名をデータベースに保存する
    end

    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new", status: :unprocessable_entity)
    end
  end

  def edit #書き込まれた内容の編集
    @post = Post.find_by(id: params[:id])
  end

  def update #編集された内容を保存する
    @post = Post.find_by(id: params[:id])            
    @post.content = params[:content]  
    @post.image_url = "#{@post.id}.jpg"
    
    if params[:image].present? # 画像が送信された場合の処理
      @post.image_url = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_url}", image.read)
    else
        @post.image_url = @post.image_url_was #画像が送信されていない場合は既存の画像URLを保持
    end
    
    if @post.save         
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit", status: :unprocessable_entity)
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
