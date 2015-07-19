#Generado con Keppler.
require_dependency "keppler_blog/application_controller"

module KepplerBlog
  class BlogController < ApplicationController  
    layout 'frontend/application'
    before_action :set_data_widgets, only: [:index, :show, :filter, :filter_subcategory]

    def index
      @posts = Post.searching(params[:query]).where(public: true).page(@current_page).per(1)
    end

    def show   
      @post =  Post.find_by_permalink(params[:permalink])   
    end

    def filter
      @posts = Post.send("filter_by_#{params[:type]}", params[:permalink]).page(@current_page).per(10)
      render action: 'index'
    end

    def filter_subcategory
      @posts = Post.filter_by_subcategory(params[:category], params[:subcategory]).page(@current_page).per(10)
      render action: 'index'
    end

    private

    def set_data_widgets
      @posts_recents = Post.where(public: true).order("created_at DESC").first(6)
      @categories = Category.all.order(:name)
    end

  end
end
