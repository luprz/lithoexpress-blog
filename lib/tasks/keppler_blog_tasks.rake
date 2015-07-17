require File.expand_path('../../keppler_blog/tasks/install', __FILE__)

namespace :keppler_blog do
	desc "Copiar inicializador para la configuración"
	task :copy_initializer do
		KepplerBlog::Tasks::Install.copy_initializer_file
	end

  desc "Copiar vistas al proyecto"
  task :copy_views do
    KepplerBlog::Tasks::Install.copy_view_files
  end
end