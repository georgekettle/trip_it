class SavesController < ApplicationController
  before_action :set_save, only: [:show, :edit, :update, :destroy]

  # GET /saves
  # GET /saves.json
  def index
    @saves = Save.all
  end

  # GET /saves/1
  # GET /saves/1.json
  def show
  end

  # GET /saves/new
  def new
    @save = Save.new
    @post = Post.find(params[:post_id])
  end

  # GET /saves/1/edit
  def edit
    @post = Post.find(@save.post_id)
  end

  # POST /saves
  # POST /saves.json
  def create
    @save = Save.new(save_params)
    @post = Post.find(params[:post_id])
    @save.post = @post

    respond_to do |format|
      if @save.save
        format.html { redirect_to @post, notice: "Post saved" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :new, alert: "Oops! There was an error saving the post" }
        format.json { render json: @save.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saves/1
  # PATCH/PUT /saves/1.json
  def update
    @post = Post.find(@save.post_id)
    respond_to do |format|
      if @save.update(save_params)
        format.html { redirect_to @post, notice: "Post saved" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @save.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saves/1
  # DELETE /saves/1.json
  def destroy
    @post = @save.post
    @save.destroy
    respond_to do |format|
      format.html { redirect_to post_url(@post), notice: 'Save was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_save
      @save = Save.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def save_params
      params.require(:save).permit(:post_id, :board_id)
    end
end
