require "keppler_blog/engine"

module KepplerBlog
	ROUTE_SIDEBAR = true

  mattr_accessor :widget_twitter_id, :twitter_username, :facebook_app_id, :posts_per_page

  def self.setup
    yield self
  end
end
