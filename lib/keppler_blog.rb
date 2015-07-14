require "keppler_blog/engine"

module KepplerBlog
	ROUTE_SIDEBAR = true

	# true/false si desea que se autentiquen los usuarios para poder usar el modulo en el frontend
  mattr_accessor :widget_twitter_id


  # Default way to setup ContactUs. Run rake contact_us:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
