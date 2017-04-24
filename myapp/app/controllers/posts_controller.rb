class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def new
    @post = Post.new
    @user = User.find(current_user.id)
  end

  def create
    @post = Post.create(params.require(:post).permit(:content, :place, :user_id).merge(:user_id => current_user.id))
    @user = User.find(@post.user_id)
  end

  def edit
    @post = Post.find(params[:id])

    if @post.user_id != current_user.id
      redirect_to '/posts'
      flash[:alert] = '無効なユーザーです。'
    end

    @user = User.find(@post.user_id)
  end

  def update
    @post = Post.find(params[:id])

    if @post.user_id != current_user.id
      redirect_to '/posts'
      flash[:alert] = '無効なユーザーです。'
    end

    @post.update(params.require(:post).permit(:content, :place))
    @user = User.find(@post.user_id)
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user_id != current_user.id
      redirect_to '/posts'
      flash[:alert] = '無効なユーザーです。'
    end

    @post.destroy
    @user = User.find(@post.user_id)
  end
end
