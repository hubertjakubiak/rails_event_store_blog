class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    post_id = SecureRandom.uuid

    command = CreatePost.new(
      post_id: post_id,
      title: post_params[:title],
      body: post_params[:body]
    )
    command.call

    post = Post.find(post_id)
    redirect_to post, notice: "Post was successfully created."

  rescue StandardError => e
    redirect_to new_post_path, alert: e.message
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    post_id = @post.id

    command = UpdatePost.new(
      post_id: post_id,
      title: post_params[:title],
      body: post_params[:body]
    )
    command.call

    redirect_to @post, notice: "Post was successfully updated."
  rescue StandardError => e
    redirect_to new_post_path, alert: e.message
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    post_id = @post.id

    command = DeletePost.new(
      post_id: post_id
    )
    command.call

    redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
