KepplerBlog::Engine.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'

	 scope :admin, :blog do
  	resources :posts do 
      get 'find/subcategories', action: :subcategories_of_cagegory, on: :collection
      get '(page/:page)', action: :index, on: :collection, as: 'search'
      delete '/destroy_multiple', action: :destroy_multiple, on: :collection, as: :destroy_multiple
    end

    resources :categories do
      get '(page/:page)', action: :index, on: :collection, as: 'search'
      delete '/destroy_multiple', action: :destroy_multiple, on: :collection, as: :destroy_multiple
    end
  end

  scope :blog do
    get '(page/:page)', to: 'blog#index', as: :blog_listing
    get ":type/:permalink", to: 'blog#filter', as: :filter
    get "category/:category/subcategory/:subcategory", to: 'blog#filter_subcategory', as: :filter_subcategory
    get '/:permalink', to: 'blog#show', as: :blog_show_post
  end

end
