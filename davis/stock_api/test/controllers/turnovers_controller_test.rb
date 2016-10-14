require 'test_helper'

class TurnoversControllerTest < ActionDispatch::IntegrationTest
  setup do
    @turnover = turnovers(:one)
  end

  test "should get index" do
    get turnovers_url
    assert_response :success
  end

  test "should get new" do
    get new_turnover_url
    assert_response :success
  end

  test "should create turnover" do
    assert_difference('Turnover.count') do
      post turnovers_url, params: { turnover: {  } }
    end

    assert_redirected_to turnover_url(Turnover.last)
  end

  test "should show turnover" do
    get turnover_url(@turnover)
    assert_response :success
  end

  test "should get edit" do
    get edit_turnover_url(@turnover)
    assert_response :success
  end

  test "should update turnover" do
    patch turnover_url(@turnover), params: { turnover: {  } }
    assert_redirected_to turnover_url(@turnover)
  end

  test "should destroy turnover" do
    assert_difference('Turnover.count', -1) do
      delete turnover_url(@turnover)
    end

    assert_redirected_to turnovers_url
  end
end
