require "keppler_blog/engine"

module KepplerBlog
	ROUTES_TREE_SIDEBAR = { icon: "local_library", title: "blog", routes: { 'keppler_blog/posts' => "/blog/posts", 'keppler_blog/categories' => "blog/posts/categories" }}

	# true/false si desea que se autentiquen los usuarios para poder usar el modulo en el frontend
  mattr_accessor :widget_twitter_id


  # Default way to setup ContactUs. Run rake contact_us:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
