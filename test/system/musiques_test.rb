require "application_system_test_case"

class MusiquesTest < ApplicationSystemTestCase
  setup do
    @musique = musiques(:one)
  end

  test "visiting the index" do
    visit musiques_url
    assert_selector "h1", text: "Musiques"
  end

  test "should create musique" do
    visit musiques_url
    click_on "New musique"

    fill_in "Description", with: @musique.description
    fill_in "Image", with: @musique.image
    fill_in "Subtitle", with: @musique.subtitle
    fill_in "Title", with: @musique.title
    click_on "Create Musique"

    assert_text "Musique was successfully created"
    click_on "Back"
  end

  test "should update Musique" do
    visit musique_url(@musique)
    click_on "Edit this musique", match: :first

    fill_in "Description", with: @musique.description
    fill_in "Image", with: @musique.image
    fill_in "Subtitle", with: @musique.subtitle
    fill_in "Title", with: @musique.title
    click_on "Update Musique"

    assert_text "Musique was successfully updated"
    click_on "Back"
  end

  test "should destroy Musique" do
    visit musique_url(@musique)
    click_on "Destroy this musique", match: :first

    assert_text "Musique was successfully destroyed"
  end
end
