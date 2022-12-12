class PostsController < AfterLoginApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @user = current_user
    @posts = Post.all.order("posts.created_at desc").includes(:comments).order("comments.created_at desc")
  end

  # GET /posts/1 or /posts/1.json
  def show
    @user = current_user
  end

  # GET /posts/new
  def new
    @user = current_user
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @user = current_user
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "ツイートしました." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "ツイートを更新しました." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    Comment.where(post_id: @post.id).destroy_all
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "ツイートを削除しました." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :content)
    end
end
