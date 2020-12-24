class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  def index
    @boards = current_user.boards
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board_user = @board.board_users.new(user_id: current_user.id)

    respond_to do |format|
      if @board.save & @board_user
        format.html { redirect_to @board, success: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to profile_url(current_user), destroyed: 'board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
private
  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.require(:board).permit(:title)
  end
end
