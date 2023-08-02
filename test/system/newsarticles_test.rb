require "application_system_test_case"

class NewsarticlesTest < ApplicationSystemTestCase
  setup do
    @newsarticle = newsarticles(:one)
  end

  test "visiting the index" do
    visit newsarticles_url
    assert_selector "h1", text: "Newsarticles"
  end

  test "should create newsarticle" do
    visit newsarticles_url
    click_on "New newsarticle"

    fill_in "Comphoto", with: @newsarticle.comphoto
    fill_in "Content", with: @newsarticle.content
    fill_in "Image", with: @newsarticle.image
    fill_in "Subtitle", with: @newsarticle.subtitle
    fill_in "Title", with: @newsarticle.title
    fill_in "Type", with: @newsarticle.type
    fill_in "User", with: @newsarticle.user_id
    click_on "Create Newsarticle"

    assert_text "Newsarticle was successfully created"
    click_on "Back"
  end

  test "should update Newsarticle" do
    visit newsarticle_url(@newsarticle)
    click_on "Edit this newsarticle", match: :first

    fill_in "Comphoto", with: @newsarticle.comphoto
    fill_in "Content", with: @newsarticle.content
    fill_in "Image", with: @newsarticle.image
    fill_in "Subtitle", with: @newsarticle.subtitle
    fill_in "Title", with: @newsarticle.title
    fill_in "Type", with: @newsarticle.type
    fill_in "User", with: @newsarticle.user_id
    click_on "Update Newsarticle"

    assert_text "Newsarticle was successfully updated"
    click_on "Back"
  end

  test "should destroy Newsarticle" do
    visit newsarticle_url(@newsarticle)
    click_on "Destroy this newsarticle", match: :first

    assert_text "Newsarticle was successfully destroyed"
  end
end
