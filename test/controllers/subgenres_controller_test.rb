require 'test_helper'

class SubgenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subgenre = subgenres(:one)
  end

  test "should get index" do
    get subgenres_url
    assert_response :success
  end

  test "should get new" do
    get new_subgenre_url
    assert_response :success
  end

  test "should create subgenre" do
    assert_difference('Subgenre.count') do
      post subgenres_url, params: { subgenre: { genre_id: @subgenre.genre_id, name: @subgenre.name } }
    end

    assert_redirected_to subgenre_url(Subgenre.last)
  end

  test "should show subgenre" do
    get subgenre_url(@subgenre)
    assert_response :success
  end

  test "should get edit" do
    get edit_subgenre_url(@subgenre)
    assert_response :success
  end

  test "should update subgenre" do
    patch subgenre_url(@subgenre), params: { subgenre: { genre_id: @subgenre.genre_id, name: @subgenre.name } }
    assert_redirected_to subgenre_url(@subgenre)
  end

  test "should destroy subgenre" do
    assert_difference('Subgenre.count', -1) do
      delete subgenre_url(@subgenre)
    end

    assert_redirected_to subgenres_url
  end
end
