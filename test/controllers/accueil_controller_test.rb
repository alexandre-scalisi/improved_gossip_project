require 'test_helper'

class AccueilControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get accueil_show_url
    assert_response :success
  end

end
