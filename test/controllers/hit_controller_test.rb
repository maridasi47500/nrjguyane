require "test_helper"

class HitControllerTest < ActionDispatch::IntegrationTest
  test "should get post" do
    get hit_post_url
    assert_response :success
  end

  test "should get historique" do
    get hit_historique_url
    assert_response :success
  end
end
