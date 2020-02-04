require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "should get index" do
    get api_v1_comments_url, as: :json
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post api_v1_comments_url, params: { comment: { body: @comment.body, post_id: @comment.post_id, published: @comment.published, user_id: @comment.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show comment" do
    get api_v1_comment_url(@comment), as: :json
    assert_response :success
  end

  test "should update comment" do
    patch api_v1_comment_url(@comment), params: { comment: { body: @comment.body, post_id: @comment.post_id, published: @comment.published, user_id: @comment.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete api_v1_comment_url(@comment), as: :json
    end

    assert_response 204
  end
end
