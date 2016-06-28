class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    @post.user = current_user
    # create post then assign owner

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(@post.user, @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    if @post.user != current_user
      redirect_to home_path, notice: "This post doesn't belong to you!"
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.user == current_user
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to [current_user, @post], notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_url(current_user), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      user = User.find(params[:user_id])
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end

end
