require "test_helper"

class ErrorTemplateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get error_template_index_url
    assert_response :success
  end
end
