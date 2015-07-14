require 'test_helper'

module KepplerBlog
  class PostsControllerTest < ActionController::TestCase
    setup do
      @post = keppler_blog_posts(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:posts)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create post" do
      assert_difference('Post.count') do
        post :create, post: { body: @post.body, category_id: @post.category_id, comments_open: @post.comments_open, image: @post.image, permalink: @post.permalink, public: @post.public, shared_enabled: @post.shared_enabled, subcategory_id: @post.subcategory_id, title: @post.title, user_id: @post.user_id }
      end

      assert_redirected_to post_path(assigns(:post))
    end

    test "should show post" do
      get :show, id: @post
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @post
      assert_response :success
    end

    test "should update post" do
      patch :update, id: @post, post: { body: @post.body, category_id: @post.category_id, comments_open: @post.comments_open, image: @post.image, permalink: @post.permalink, public: @post.public, shared_enabled: @post.shared_enabled, subcategory_id: @post.subcategory_id, title: @post.title, user_id: @post.user_id }
      assert_redirected_to post_path(assigns(:post))
    end

    test "should destroy post" do
      assert_difference('Post.count', -1) do
        delete :destroy, id: @post
      end

      assert_redirected_to posts_path
    end
  end
end
