class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :save, :new_save]

  def show
  end

  def new
    @post = Post.new
    @post.location = Location.new
    @post.photo = Photo.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.photo = Photo.new(post_params[:photo_attributes])
    create_location

    respond_to do |format|
      if @post.save && @post.location.save
        format.html { redirect_to @post, success: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, alert: "Oops! There was an error saving the post" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def edit
  end

  def update
    create_location
    respond_to do |format|
      if @post.update(post_params.except(:photo_attributes)) && @post.location.save
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to profile_url(current_user), destroyed: 'post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def new_save
  # end

  # def save
  #   @new_post = @post.dup unless @post.user == current_user
  #   @new_post.user = current_user
  #   @save = Save.new(original_post_id: @post.id)
  #   respond_to do |format|
  #     if @new_post.update(post_params) && @save.update(saved_post_id: @new_post.id)
  #       format.html { redirect_to @new_post, notice: "Post saved to '#{@new_post.board.title.capitalize}'." }
  #       format.json { render :show, status: :ok, location: @new_post }
  #       format.js
  #     else
  #       format.html { render :new_save, alert: "Oops! There was an error saving the post" }
  #       format.json { render json: @new_post.errors, status: :unprocessable_entity }
  #       format.js
  #     end
  #   end
  # end

private

  def create_location
    @post.location = Location.where(longitude: post_params[:location_attributes][:longitude], latitude: post_params[:location_attributes][:latitude]).first_or_create(post_params[:location_attributes])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :board_id, location_attributes: [:longitude, :latitude, :address, :title, :id], photo_attributes: [:image, :id])
  end
end
