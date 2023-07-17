require "application_system_test_case"

class EmissionsTest < ApplicationSystemTestCase
  setup do
    @emission = emissions(:one)
  end

  test "visiting the index" do
    visit emissions_url
    assert_selector "h1", text: "Emissions"
  end

  test "should create emission" do
    visit emissions_url
    click_on "New emission"

    fill_in "Description", with: @emission.description
    fill_in "Image", with: @emission.image
    fill_in "Name", with: @emission.name
    click_on "Create Emission"

    assert_text "Emission was successfully created"
    click_on "Back"
  end

  test "should update Emission" do
    visit emission_url(@emission)
    click_on "Edit this emission", match: :first

    fill_in "Description", with: @emission.description
    fill_in "Image", with: @emission.image
    fill_in "Name", with: @emission.name
    click_on "Update Emission"

    assert_text "Emission was successfully updated"
    click_on "Back"
  end

  test "should destroy Emission" do
    visit emission_url(@emission)
    click_on "Destroy this emission", match: :first

    assert_text "Emission was successfully destroyed"
  end
end
