class UserController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
    User.create(
      email: params[:email],
      password: params[:password]
    )
  end
  
  def login
    
  end
  
  # 1. DB에 유저가 없을 때(params[:email]로 DB 검색시 없을때) => "니가 입력한 이메일의 아이디가 존재하지 않아요"
  # 2. DB에 유저가 있는데,
      # - 패스워드가 다를 때 => "패스워드가 틀렸어"
      # - 패스워드가 맞을 때 => "로그인"
  def login_process
    @user = User.find_by(email: params[:email])
    if @user
      if @user.password == params[:password]
        flash[:notice] = "로그인 됬어요"
        session[:user_id] = @user.id
        redirect_to '/'
      else
        flash[:notice] = "패스워드가 틀렸어요"
        redirect_to '/user/login'
      end
    else
      flash[:notice] = "그런 이메일의 유저가 없어"
      redirect_to '/user/new'
    end
  end
  
  def logout
    session.clear
    redirect_to '/'
  end
end
