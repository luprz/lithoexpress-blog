#Generado con Keppler.
require_dependency "keppler_blog/application_controller"

module KepplerBlog
  class PostsController < ApplicationController  
    before_filter :authenticate_user!
    layout 'admin/application'
    load_and_authorize_resource
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts
    def index
      posts = Post.searching(@query).all
      @objects, @total = posts.page(@current_page), posts.size
      redirect_to posts_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
    end

    # GET /posts/1
    def show
    end

    # GET /posts/new
    def new
      @post = Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end

    def destroy_multiple
      Post.destroy redefine_ids(params[:multiple_ids])
      redirect_to posts_path(page: @current_page, search: @query), notice: "Usuarios eliminados satisfactoriamente" 
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:title, :body, :user_id, :category_id, :subcategory_id, :image, :public, :comments_open, :shared_enabled, :permalink)
      end
  end
end