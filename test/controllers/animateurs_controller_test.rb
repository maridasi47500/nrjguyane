require "test_helper"

class AnimateursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animateur = animateurs(:one)
  end

  test "should get index" do
    get animateurs_url
    assert_response :success
  end

  test "should get new" do
    get new_animateur_url
    assert_response :success
  end

  test "should create animateur" do
    assert_difference("Animateur.count") do
      post animateurs_url, params: { animateur: { description: @animateur.description, image: @animateur.image, name: @animateur.name } }
    end

    assert_redirected_to animateur_url(Animateur.last)
  end

  test "should show animateur" do
    get animateur_url(@animateur)
    assert_response :success
  end

  test "should get edit" do
    get edit_animateur_url(@animateur)
    assert_response :success
  end

  test "should update animateur" do
    patch animateur_url(@animateur), params: { animateur: { description: @animateur.description, image: @animateur.image, name: @animateur.name } }
    assert_redirected_to animateur_url(@animateur)
  end

  test "should destroy animateur" do
    assert_difference("Animateur.count", -1) do
      delete animateur_url(@animateur)
    end

    assert_redirected_to animateurs_url
  end
end
