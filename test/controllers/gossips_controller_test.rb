require 'test_helper'

class GossipsControllerTest < ActionDispatch::IntegrationTest
  test 'should get names' do
    get gossips_names_url
    assert_response :success
  end
end
