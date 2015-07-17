require "keppler_blog/engine"

module KepplerBlog
	ROUTE_SIDEBAR = true

  mattr_accessor :widget_twitter_id

  def self.setup
    yield self
  end
end
