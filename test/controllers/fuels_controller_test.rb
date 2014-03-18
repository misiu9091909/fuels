require 'test_helper'

class FuelsControllerTest < ActionController::TestCase
  test "should get check_remote" do
    get :check_remote
    assert_response :success
  end

end
