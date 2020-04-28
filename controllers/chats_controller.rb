class ChatsController < ApplicationController
  before_action :authenticate_user
  
  def index 
  end
  
  
  def new
    @chat = Chat.new
  end
  
  
  def create
    @user = User.find_by(id: params[:id])
    @chat = Chat.new(
      content:  params[:content],
      user_id: @current_user.id,
      image_name: @current_user.image_name,
      name: @current_user.name,
      post_id: params[:post_id]
      )
      
    if @chat.save
      redirect_to("/users/#{@chat.post_id}/chat")
    end
  end
  
  
  def destroy
    @chat = Chat.find_by(id: params[:id])
    @chat.destroy
      redirect_to("/users/#{@chat.post_id}/chat")
  end
  
end
