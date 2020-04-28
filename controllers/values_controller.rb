class ValuesController < ApplicationController
  before_action :authenticate_user
  
  def index
    @values = Value.all.order(created_at: :desc)
  end
  
  
  def new
    @value = Value.new
  end
  
  
  def create
    @post = Post.find_by(id: params[:id])
    @value = Value.new(value_params)
      
    if @value.save
      redirect_to("/posts/#{@value.post_id}/list")
    else
      redirect_to("/posts/#{@value.post_id}/list")
    end
  end
  
  
  def edit
    @value = Value.find_by(id: params[:id])
  end
  
  
  def update
    @value = Value.find_by(id: params[:id])
    
    if @value.update(update_params)
      flash[:notice] = "評価を編集しました"
      redirect_to("/posts/#{@value.post_id}/list")
    else
      render("/posts/index")
    end
  end
  
  def destroy
    @value = Value.find_by(id: params[:id])
    @value.destroy
    
    flash[:notice] = "評価を削除しました"
    redirect_to("/posts/#{@value.post_id}/list")
  end
  
  
  private

  def value_params
    params.require(:value).
           permit(:title, :rate, :content, :post_id).
           merge(
           user_id: @current_user.id, 
           name: @current_user.name, 
           image_name: @current_user.image_name, 
           post_id: params[:id])
  end
  
  
  def update_params
    params.require(:value)
          .permit(:title, :rate, :content)
  end
  
end
