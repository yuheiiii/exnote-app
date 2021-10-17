class RoomController < ApplicationController

  before_action :authenticate_user
  before_action :authenticate_room, {only:[:comment_index, :comment, :note, :show]}
  before_action :forbid_login_room, {only:[:comment_index, :comment, :note, :show]}

  def index
  end
  
  def new
  end

  def create
    @room = Room.new(room_params)
    
    if @room.save
      session[:room_id] = @room.id
      flash[:notice] = "ルームを作成しました"
      redirect_to("/room/#{@room.id}/note_index")
    else
      @errormessage ="入力内容に重複または空欄があります"
      render("room/new")
    end

  end

  def join_form
  end

  def join
    @room = Room.find_by(room_id: params[:room_id])
    if @room && @room.authenticate(params[:password])
      flash[:notice] ="ルームに入室しました"
      session[:room_id] = @room.id
      redirect_to("/room/#{@room.id}/note_index")
    else
      @errormessage = "idまたはパスワードが間違っています"
      render("room/join_form")
    end
  end

  def out
    session[:room_id] = nil
    flash[:notice] ="ルームを退出しました"
    redirect_to("/room/index")
  end

  def comment
  end

  def comment_index
    @posts = Image2.where(room_number: @current_room.id).order(created_at: :desc)
  end

  def room_params
    params.require(:room).permit(:room_id, :password)
  end

  def note_index
    @notes = Image.where(room_number:@current_room.id).order(created_at: :desc)
  end

  def new_note
    @note = Image.new
  end

  def note_create
    @note = Image.new(note_params)

    if @note.save
      flash[:notice] = "ノートを投稿しました"
      @post = Image2.new(image_name:"#{@current_user.name} さんがノートを投稿しました", room_number: @current_room.id, user_id:@current_user.id)
      @post.save
      redirect_to("/room/#{@current_room.id}/note_index")
    else
      render("room/#{@current_room.id}/new_note")
    end
  end

  def note_comment
    @note = Image.find_by(id:params[:id])
    @posts = Post.where(post_id:params[:id])
  end

 def room_params
  params.permit(:room_id, :password)
 end 

  def note_params
    params.require(:image).permit(:image).merge(room_number:@current_room.id, user_id:@current_user.id, image_name:@current_user.name)
  end


end
