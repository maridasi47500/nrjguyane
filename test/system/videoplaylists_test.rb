require "application_system_test_case"

class VideoplaylistsTest < ApplicationSystemTestCase
  setup do
    @videoplaylist = videoplaylists(:one)
  end

  test "visiting the index" do
    visit videoplaylists_url
    assert_selector "h1", text: "Videoplaylists"
  end

  test "should create videoplaylist" do
    visit videoplaylists_url
    click_on "New videoplaylist"

    click_on "Create Videoplaylist"

    assert_text "Videoplaylist was successfully created"
    click_on "Back"
  end

  test "should update Videoplaylist" do
    visit videoplaylist_url(@videoplaylist)
    click_on "Edit this videoplaylist", match: :first

    click_on "Update Videoplaylist"

    assert_text "Videoplaylist was successfully updated"
    click_on "Back"
  end

  test "should destroy Videoplaylist" do
    visit videoplaylist_url(@videoplaylist)
    click_on "Destroy this videoplaylist", match: :first

    assert_text "Videoplaylist was successfully destroyed"
  end
end
