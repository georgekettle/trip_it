class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @post = Post.new
    @post.locations = [Location.new]
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    create_photo
    # create_locations

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, success: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
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
private
  # def create_locations
  #   @post.locations.each do |location|
  #     location.save
  #   end
  # end

  def create_photo
    if params[:post][:photo]
      cloudinary_obj = Cloudinary::Uploader.upload(params[:post][:photo])
      @photo = Photo.new(url: cloudinary_obj["secure_url"], cloudinary_id: cloudinary_obj["public_id"])
      if @photo.save
        @post.photo_id = @photo.id
      else
        Cloudinary::Api.delete_resources([cloudinary_obj["public_id"]])
      end
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :description, :board_id, :photo_id, locations_attributes: [:id, :longitude, :latitude, :_destroy])
  end
end
