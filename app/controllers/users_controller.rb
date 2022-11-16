class UsersController < ApplicationController



  def create
    @user = User.new(email: params[:user][:email], password: params[:user][:password])
    if @user.save
      login(@user)
      redirect_to user_url(@user.id)
    else
      redirect_to users_url
    end
  end

  def new
    render :new
  end

  def index
    users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end
end
