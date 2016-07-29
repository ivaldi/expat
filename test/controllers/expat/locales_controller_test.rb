require 'test_helper'

module Expat
  class LocalesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should get index' do
      get root_url
      assert_response :success
      assert_select 'li', 2
      assert_match(/<li>nl<\/li>/, response.body)
    end
  end
end
