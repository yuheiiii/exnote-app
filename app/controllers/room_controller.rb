class RoomController < ApplicationController

  before_action :authenticate_user
  before_action :authenticate_room, {only:[:comment_index, :comment, :note, :show]}
  before_action :forbid_login_room, {only:[:comment_index, :comment, :note, :show]}

  def index
  end
  
  def new
  end

  def create
    @room = Room.new(room_id: params[:room_id], password: params[:password])
    
    if @room.save
      session[:room_id] = @room.id
      flash[:notice] = "ルームを作成しました"
      redirect_to("/room/#{@room.id}")
      @note = Image.new(room_number: @room.id, 
                      image_name: "default_note.jpg",
                      user_id: @current_user.id)
     @note.save

     @note2 = Image2.new(room_number: @room.id, 
                        image_name: "default_note2.jpg", 
                        user_id: @current_user.id)
     @note2.save

     @note3 = Image3.new(room_number: @room.id, 
                        image_name: "default_note3.jpg", 
                        user_id: @current_user.id)
     @note3.save
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
      redirect_to("/room/#{@room.id}")
    else
      @errormessage = "idまたはパスワードが間違っています"
      render("room/join_form")
    end
  end

  def show
    @note = Image.find_by(room_number: @current_room.id)
    @user = User.find_by(id: @note.user_id)
    @note2 = Image2.find_by(room_number:@current_room.id)
    @user2 = User.find_by(id: @note2.user_id)
    @note3 = Image3.find_by(room_number:@current_room.id)
    @user3 = User.find_by(id: @note3.user_id)
  end

  def note
    @note = Image.find_by(id: params[:id])
    @user = User.find_by(id: @note.user.id)
    @posts = Post.find_by(post_id: @note.id, room_id: @current_room.id)
  end

  def out
    session[:room_id] = nil
    flash[:notice] ="ルームを退出しました"
    redirect_to("/room/index")
  end

  def comment
  end

  def comment_index
    @posts = Post.where(room_id: @current_room.id).order(created_at: :desc)
  end

  def room_params
    params.require(:room).permit(:room_id, :password)
  end

end
