class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  
  def show
    @posts = Post.where(user_id: params[:id]).order(created_at: :desc)
    @user = User.find_by(id: params[:id])
  end
  
  
  def new
    @user = User.new
  end
  
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      password: params[:password],
      repassword: params[:repassword]
    )
    
    unless @user.password == @user.repassword
      flash[:notice] = "パスワードが異なります"
      render action: :new
      return
    end
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
  
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  
  def login_form
  end
  
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  
  def logout
    session[:user_id] = nil
    flash.now[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
  
  
  def chat
    @user = User.find_by(id: params[:id])
    @chats = Chat.where(post_id: @user.id)
    @chat = Chat.find_by(post_id: params[:id])
  end
  
  
  def email
  end
  
  
  def submit
    @user = User.find_by(email: params[:email])
    
    if @user.save
      redirect_to("/password/#{@user.id}")
    else
      redirect_to("/email")
    end
  end
  
  
  def password
    @user = User.find_by(id: params[:id])
  end
  
  
  def reset
    @user = User.find_by(id: params[:id])
    @user.password = params[:password]
    @user.repassword = params[:repassword]
    
    unless @user.password == @user.repassword
      flash[:notice] = "パスワードが異なります"
      render action: :password
      return
    end
    
    if @user.save
      redirect_to("/repassword")
    else
      render("/password/#{@user.id}")
    end
  end
  
  
  def repassword
  end
  
  
  def history
    @user = User.find_by(id: params[:id])
    @buys = Buy.where(user_id: params[:id]).order(created_at: :desc)
  end
  
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    @post = Post.find_by(user_id: params[:id])
    @chat = Chat.find_by(user_id: params[:id])
    @value = Value.find_by(user_id: params[:id])
    @like = Like.find_by(user_id: params[:id])
    @buy = Buy.find_by(user_id: params[:id])
    
    if @post
      @post.destroy
    end    
    
    if @chat
      @chat.destroy
    end    
    
    if @value
      @value.destroy
    end    
    
    if @like
      @like.destroy
    end
        
    if @buy
      @buy.destroy
    end
    
    flash[:notice] = "退会しました"
    redirect_to("/")
  end
  
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
