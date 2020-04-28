class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:show, :new, :list, :edit, :buy]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.paginate(page: params[:page], per_page: 5).search(params[:search])
                 .category(params[:category]).order(created_at: :desc)
  end
  
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @stars = Value.where(post_id: @post.id)
    @value = Value.new
  end
  
  
  def new
    @post = Post.new
  end
  
  
  def create
    @post = Post.new(
      content:       params[:content],
      title:         params[:title],
      category:      params[:category],
      price:         params[:price],
      user_id:       @current_user.id,
      name:       @current_user.name,
      image_name: "default_post.jpg"
      )
      
    if params[:image]
      @post.image_name = "#{@post.title}.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}", image.read)
    end
  
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end
  end
  
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.title =      params[:title]
    @post.category =   params[:category]
    @post.content =    params[:content]
    @post.price =      params[:price]
    
    if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}", image.read)
    end
    
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("/posts/edit")
    end
  end 
  
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  
  def list
    @post = Post.find_by(id: params[:id])
    @stars = Value.where(post_id: @post.id)
    @value = Value.new
  end
  
  
  def buy
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @buy = Buy.new
  end
  
  
  def pay
    Payjp.api_key = 'sk_test_9a87c20b8288be01d81e7316'
    Payjp::Charge.create(
      amount: 3500, # 決済する値段
      card: params['payjp-token'],
      currency: 'jpy'
    )
  end
  
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
