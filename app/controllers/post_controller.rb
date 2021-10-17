class PostController < ApplicationController

  before_action :authenticate_user

 def note_comment_create
    @comment = Post.new(comment_params)
    @note = Image.find_by(id:params[:id])
    @user = User.find_by(id:@note.user_id)
   if @comment.save
     flash[:notice] = "コメントを投稿しました"
     @notification = Image2.new(room_number:@current_room.id, image_name:"#{@current_user.name} さんが #{@user.name} さんの投稿にコメントしました", user_id:@current_user.id)
     @notification.save
     redirect_to("/room/#{@current_room.id}/note_comment/#{params[:id]}")
   else
     redirect_to("/room/#{@current_room.id}/note_comment/#{params[:id]}") 
   end
 end

 def comment_params
   params.permit(:content).merge(user_id:@current_user.id, room_id:@current_room.id, post_id:params[:id])
 end


end

