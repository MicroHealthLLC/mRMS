require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @news = news(:one)
    sign_in @admin 
  end

  test "should get index" do
    get news_index_url
    assert_response :success
  end
  test "should get news" do
    get new_news_url
    assert_response :success
  end

  test "should create news" do
    assert_difference('News.count') do
      post news_index_url, params: { news: { title: 'Title', summary: 'summary', user_id: @admin.id, description: 'Description'  } }
    end

    assert_redirected_to news_url(News.last)
  end

  test "should show new" do
    get news_index_url(@news)
    assert_response :success
  end

  test "should get edit" do
    get edit_news_url(@news)
    assert_response :success
  end

  test "should update news" do
    patch news_url(@news), params: { news: { title: 'new title', summary: 'summary', user_id: @news.user_id, description: 'Description' } }
    assert_redirected_to news_url(@news)
    @news.reload
    assert_equal 'new title', @news.title 
  end

  test "should destroy news" do
    assert_difference('News.count', -1) do
      delete news_url(@news)
    end
    assert_redirected_to news_index_url
  end
end
