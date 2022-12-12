class CommentsController < AfterLoginApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    if params[:post_id] != nil then
      @post_id = params[:post_id]
    else
      raise ActionController::RoutingError
    end

    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    if params[:post_id] != nil then
      @post_id = params[:post_id]
    else
      raise ActionController::RoutingError
    end
    
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: "コメントしました." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "コメントを更新しました." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "コメントを削除しました." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
