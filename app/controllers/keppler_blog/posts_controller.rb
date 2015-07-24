#Generado con Keppler.
require_dependency "keppler_blog/application_controller"

module KepplerBlog
  class PostsController < ApplicationController  
    before_filter :authenticate_user!
    layout 'admin/application'
    load_and_authorize_resource except: [:subcategories_of_cagegory]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :set_categories, only: [:new, :edit, :update, :create]

    # GET /posts
    def index
      posts = current_user.has_role?(:autor) ? Post.searching(@query).where(user_id: current_user.id) : Post.searching(@query).all
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
      @post = Post.new(post_params.merge(user_id: current_user.id))

      if @post.save
        redirect_to @post, notice: 'Post creado satisfactoriamente'
      else
        render :new
      end
    end

    # PATCH/PUT /posts/1
    def update
      @post.subcategory_id = nil if post_params[:subcategory_id].nil?
      
      if @post.update(post_params)
        redirect_to @post, notice: 'Post actualizado satisfactoriamente'
      else
        render :edit
      end
    end


    def subcategories_of_cagegory
      @category = Category.find(params[:category_id])
      @subcategories = @category.subcategories
      respond_to do |format|
         format.js {  }
      end
    end


    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post eliminado satisfactoriamente'
    end

    def destroy_multiple
      Post.destroy redefine_ids(params[:multiple_ids])
      redirect_to posts_path(page: @current_page, search: @query), notice: "Posts eliminados satisfactoriamente" 
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      def set_categories
        @categories = Category.order(:name)
      end

      # Only allow a trusted parameter "white list" through.
      def post_params
        params.require(:post).permit(:title, :body, :user_id, :category_id, :subcategory_id, :image, :public, :comments_open, :shared_enabled, :permalink, :tag_list)
      end
  end
end
