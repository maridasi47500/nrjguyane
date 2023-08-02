require "test_helper"

class VideoplaylistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @videoplaylist = videoplaylists(:one)
  end

  test "should get index" do
    get videoplaylists_url
    assert_response :success
  end

  test "should get new" do
    get new_videoplaylist_url
    assert_response :success
  end

  test "should create videoplaylist" do
    assert_difference("Videoplaylist.count") do
      post videoplaylists_url, params: { videoplaylist: {  } }
    end

    assert_redirected_to videoplaylist_url(Videoplaylist.last)
  end

  test "should show videoplaylist" do
    get videoplaylist_url(@videoplaylist)
    assert_response :success
  end

  test "should get edit" do
    get edit_videoplaylist_url(@videoplaylist)
    assert_response :success
  end

  test "should update videoplaylist" do
    patch videoplaylist_url(@videoplaylist), params: { videoplaylist: {  } }
    assert_redirected_to videoplaylist_url(@videoplaylist)
  end

  test "should destroy videoplaylist" do
    assert_difference("Videoplaylist.count", -1) do
      delete videoplaylist_url(@videoplaylist)
    end

    assert_redirected_to videoplaylists_url
  end
end
