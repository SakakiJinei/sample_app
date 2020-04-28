class BuysController < ApplicationController
  before_action :authenticate_user
  
  def new
  end
  
  
  def create
    @post = Post.find_by(id: params[:id])
    @buy = Buy.new(
      number:   params[:number],
      image_name: @post.image_name,
      title: @post.title,
      price: @post.price,
      category: @post.category,
      name: @post.name,
      post_id: params[:id],
      user_id: @current_user.id
      )
    @buy.total = @post.price.to_i * @buy.number.to_i
      
    if @buy.save
      redirect_to("/buys/#{@current_user.id}/show")
    else
      render("/posts/#{@post.id}/buy")
    end
  end
  
  
  def show
    @post = Post.find_by(id: params[:id])
    @buy = Buy.where(user_id: params[:id]).last
  end
  
  
  def destroy 
    @buy = Buy.find_by(post_id: params[:id])
    @buy.destroy
    
    flash[:notice] = "購入を辞退しました"
    redirect_to("/posts/index")
  end
  
end
