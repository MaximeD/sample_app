class UsersController < ApplicationController
  before_filter :signed_in_user,
      only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy

  attr_accessor :name, :email

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    unless signed_in?
      @user = User.new
    else
      flash[:notice] = "You are already logged in"
      redirect_to root_path
    end
  end

  def create
    unless signed_in?
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    else
      flash[:notice] = "You are already logged in"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "User #{user.name} destroyed."
    redirect_to users_url
  end

  def following
    @title  = "Following"
    @user   = User.find(params[:id])
    @users  = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title  = "Followers"
    @user   = User.find(params[:id])
    @users  = @user.followers.paginate(page: params[:id])
    render 'show_follow'
  end

  private

    # moved to lib/authenticable.rb
    # def signed_in_user
    #   unless signed_in?
    #     store_location
    #     redirect_to signin_url, notice: "Please sign in." unless signed_in?
    #   end
    # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
