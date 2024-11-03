class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    post_id = SecureRandom.uuid

    command = CreatePost.new(
      post_id: post_id,
      title: post_params[:title],
      body: post_params[:body]
    )
    command.call

    if command.success?
      post = Post.find(post_id)
      redirect_to post, notice: "Post was successfully created."
    else
      redirect_to posts_path, notice: command.error
    end
  end

  def update
    post_id = @post.id

    command = UpdatePost.new(
      post_id: post_id,
      title: post_params[:title],
      body: post_params[:body]
    )
    command.call

    if command.success?
      redirect_to @post, notice: "Post was successfully updated."
    else
      redirect_to posts_path, notice: command.error
    end
  end

  def destroy
    post_id = @post.id

    command = DeletePost.new(
      post_id: post_id
    )
    command.call

    if command.success?
      redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
    else
      redirect_to posts_path, notice: command.error
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
