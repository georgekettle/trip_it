require 'test_helper'

class SavesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @save = saves(:one)
  end

  test "should get index" do
    get saves_url
    assert_response :success
  end

  test "should get new" do
    get new_save_url
    assert_response :success
  end

  test "should create save" do
    assert_difference('Save.count') do
      post saves_url, params: { save: { board_id: @save.board_id, post_id: @save.post_id } }
    end

    assert_redirected_to save_url(Save.last)
  end

  test "should show save" do
    get save_url(@save)
    assert_response :success
  end

  test "should get edit" do
    get edit_save_url(@save)
    assert_response :success
  end

  test "should update save" do
    patch save_url(@save), params: { save: { board_id: @save.board_id, post_id: @save.post_id } }
    assert_redirected_to save_url(@save)
  end

  test "should destroy save" do
    assert_difference('Save.count', -1) do
      delete save_url(@save)
    end

    assert_redirected_to saves_url
  end
end
