KepplerBlog::Engine.routes.draw do
  
  
  resources :categories
	 scope :admin, :blog do
  	resources :posts do 
      get '(page/:page)', action: :index, on: :collection, as: 'search'
      delete '/destroy_multiple', action: :destroy_multiple, on: :collection, as: :destroy_multiple
    end
  end

  scope :admin, :blog do
    resources :categories do
      get '(page/:page)', action: :index, on: :collection, as: 'search'
      delete '/destroy_multiple', action: :destroy_multiple, on: :collection, as: :destroy_multiple
    end
  end

end
