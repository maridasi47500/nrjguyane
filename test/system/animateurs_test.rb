require "application_system_test_case"

class AnimateursTest < ApplicationSystemTestCase
  setup do
    @animateur = animateurs(:one)
  end

  test "visiting the index" do
    visit animateurs_url
    assert_selector "h1", text: "Animateurs"
  end

  test "should create animateur" do
    visit animateurs_url
    click_on "New animateur"

    fill_in "Description", with: @animateur.description
    fill_in "Image", with: @animateur.image
    fill_in "Name", with: @animateur.name
    click_on "Create Animateur"

    assert_text "Animateur was successfully created"
    click_on "Back"
  end

  test "should update Animateur" do
    visit animateur_url(@animateur)
    click_on "Edit this animateur", match: :first

    fill_in "Description", with: @animateur.description
    fill_in "Image", with: @animateur.image
    fill_in "Name", with: @animateur.name
    click_on "Update Animateur"

    assert_text "Animateur was successfully updated"
    click_on "Back"
  end

  test "should destroy Animateur" do
    visit animateur_url(@animateur)
    click_on "Destroy this animateur", match: :first

    assert_text "Animateur was successfully destroyed"
  end
end
