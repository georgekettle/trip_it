require_relative '../form_models/wizard/new_post'

class WizardsController < ApplicationController
  before_action :load_post_wizard, except: %i(validate_step)
  # before_action :load_photo, except: %i(validate_step)

  # starter point for everything
  def step1
    @photo = @post_wizard.post.photo || Photo.new
    @location = @post_wizard.post.location || Location.new
  end

  def validate_step
    current_step = params[:current_step]

    @post_wizard = wizard_post_for_step(current_step)
    create_photo if photo_params
    create_location if location_params

    @post_wizard.post.attributes = post_wizard_params.to_h
    session[:post_attributes] = @post_wizard.post.attributes

    if @post_wizard.valid?
      next_step = wizard_post_next_step(current_step)
      create and return unless next_step

      redirect_to post_wizard_url(next_step)
    else
      render current_step
    end
  end

  def create
    @post_wizard.post.user = current_user
    if @post_wizard.post.save
      session[:post_attributes] = nil
      redirect_to post_path(@post_wizard.post), notice: 'Post succesfully created!'
    else
      redirect_to(post_wizard_url("step1"), alert: 'There was a problem when creating the post.')
    end
  end

  private

  def create_location
    @post_wizard.post.location.destroy if @post_wizard.post.location
    @post_wizard.post.location = Location.create(location_params[:location_attributes])
  end

  def create_photo
    @post_wizard.post.photo.destroy if @post_wizard.post.photo
    @post_wizard.post.photo = Photo.create(photo_params[:photo_attributes])
  end

  def load_post_wizard
    @post_wizard = wizard_post_for_step(action_name)
  end

  def wizard_post_next_step(step)
    Wizard::NewPost::STEPS[Wizard::NewPost::STEPS.index(step) + 1]
  end

  def wizard_post_for_step(step)
    raise InvalidStep unless step.in?(Wizard::NewPost::STEPS)

    "Wizard::NewPost::#{step.camelize}".constantize.new(session[:post_attributes])
  end

  def location_params
    params.fetch(:post).permit(location_attributes: [:longitude, :latitude, :address, :title, :id]) if params[:post]  && params[:post][:location_attributes]
  end

  def photo_params
    params.fetch(:post).permit(photo_attributes: [:image, :id]) if params[:post] && params[:post][:photo_attributes]
  end

  def post_wizard_params
    params.fetch(:post, {}).permit(:title, :board_id)
  end

  class InvalidStep < StandardError; end
end
