module KepplerBlog
  class Engine < ::Rails::Engine
    isolate_namespace KepplerBlog
    config.generators do |g|
    	g.template_engine :haml
    end
  end
end
