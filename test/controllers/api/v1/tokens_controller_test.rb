# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class TokensControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
      end
      test 'should get JWT token' do
        post api_v1_tokens_url, params: { user: { email: @user
          .email, password: 'g00d_pa$$' } }, as: :json
        assert_response :success

        json_response = JSON.parse(response.body)
        assert_not_nil json_response['token']
      end

      test 'should not get JWT token' do
        post api_v1_tokens_url, params: { user: { email: @user
          .email, password: 'bad_pa$$' } }, as: :json
        assert_response :unauthorized
      end
    end
  end
end
