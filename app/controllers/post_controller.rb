class PostController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
    @post =Post.new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)

    if@post.save
      flash[:notice] ="投稿に成功しました"
      redirect_to("/post/index")
    else
      render("post/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] ="投稿を編集しました"
      redirect_to("/post/index")
    else
      render("post/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] ="投稿を削除しました"
    redirect_to("/post/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/post/index")
    end
  end

  def image_new
  end

  def image_new2
  end

  def  image_new3
  end
  
  def image_create
    @note = Image.find_by(room_number: @current_room.id)
    @user = User.find_by(id: @current_user.id)

    if params[:image]
      @note.image_name = "#{@current_room.id}.jpg"
      @note.user_id = @current_user.id
      image = params[:image]
      File.binwrite("app/assets/images/note/#{@note.image_name}", image.read)
    end

    if @note.save
      flash[:notice] = "ノートを投稿しました"
      @post = Post.new(content:"#{@current_user.name} がノートを投稿しました", user_id:@current_user.id, room_id: @current_room.id, post_id: params[:id] )
      @post.save
      redirect_to("/room/#{params[:id]}")
   else
      render("post/#{params[:id]}/image_new")
    end
    
  end

  def image_create2
    @note = Image2.find_by(room_number: @current_room.id)
    @user = User.find_by(id: @current_user.id)

    if params[:image]
      @note.image_name = "#{@current_room.id}.jpg"
      @note.user_id = @current_user.id
      image = params[:image]
      File.binwrite("app/assets/images/note2/#{@note.image_name}", image.read)
    end

    if @note.save
      flash[:notice] = "ノートを投稿しました"
      @post = Post.new(content:"#{@current_user.name} がノートを投稿しました", user_id:@current_user.id, room_id: @current_room.id, post_id: params[:id] )
      @post.save
      redirect_to("/room/#{params[:id]}")
   else
      render("post/#{params[:id]}/image_new")
    end
    
  end

  def image_create3
    @note = Image3.find_by(room_number: @current_room.id)
    @user = User.find_by(id: @current_user.id)

    if params[:image]
      @note.image_name = "#{@current_room.id}.jpg"
      @note.user_id = @current_user.id
      image = params[:image]
      File.binwrite("app/assets/images/note3/#{@note.image_name}", image.read)
    end

    if @note.save
      flash[:notice] = "ノートを投稿しました"
      @post = Post.new(content:"#{@current_user.name} がノートを投稿しました", user_id:@current_user.id, room_id: @current_room.id, post_id: params[:id] )
      @post.save
      redirect_to("/room/#{params[:id]}")
   else
      render("post/#{params[:id]}/image_new")
    end
    
  end

 def comment
   @comment = Post.new(content: params[:content], user_id: @current_user.id, room_id: @current_room.id, post_id: params[:id])
   if @comment.save
     flash[:notice] = "コメントを投稿しました"
     redirect_to("/room/#{@current_room.id}/comment_index")
   else
     redirect_to("/room/#{@current_room.id}/comment_index") 
   end
 end

 def post_params
  params.require(:post).permit(:content, :user_id, :room_id, :post_id, :room_number, :image_name)
end

end

