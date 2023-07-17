require "test_helper"

class EmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emission = emissions(:one)
  end

  test "should get index" do
    get emissions_url
    assert_response :success
  end

  test "should get new" do
    get new_emission_url
    assert_response :success
  end

  test "should create emission" do
    assert_difference("Emission.count") do
      post emissions_url, params: { emission: { description: @emission.description, image: @emission.image, name: @emission.name } }
    end

    assert_redirected_to emission_url(Emission.last)
  end

  test "should show emission" do
    get emission_url(@emission)
    assert_response :success
  end

  test "should get edit" do
    get edit_emission_url(@emission)
    assert_response :success
  end

  test "should update emission" do
    patch emission_url(@emission), params: { emission: { description: @emission.description, image: @emission.image, name: @emission.name } }
    assert_redirected_to emission_url(@emission)
  end

  test "should destroy emission" do
    assert_difference("Emission.count", -1) do
      delete emission_url(@emission)
    end

    assert_redirected_to emissions_url
  end
end
