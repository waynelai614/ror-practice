require 'test_helper'

class BoardControllerTest < ActionController::TestCase
  test "should get index.html" do
    get :index.html
    assert_response :success
  end

end
