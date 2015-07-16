#Generado con Keppler.
require_dependency "keppler_blog/application_controller"

module KepplerBlog
  class BlogController < ApplicationController  
    layout 'frontend/application'
    before_action :set_data_widgets, only: [:index, :show, :filet]

    def index
      @posts = Post.searching(@query).where(public: true).page(@current_page).per(10)
    end

    def show   
      @post =  Post.find_by_permalink(params[:permalink])   
    end

    def filter
    end

    private

    def set_data_widgets
      @posts_recents = Post.where(public: true).order("created_at DESC").first(6)
      @categories = Category.all.order(:name)
    end

  end
end
