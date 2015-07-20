## Keppler Blog 

Engine que integra un blog a Keppler-Admin.

## Dependencias

* [ckeditor](https://github.com/galetahub/ckeditor)
* [cocoon](https://github.com/nathanvda/cocoon)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
* [social-share-button](https://github.com/huacnlee/social-share-button)

## Requerimientos

* Ruby >= 2.0.0
* Rails >= 4.0.0
* Keppler-Admin >= 1.0.0

## Instalación

Añadir a su Gemfile

```ruby
gem 'keppler_blog', git: 'https://github.com/inyxtech/keppler_blog.git'
gem 'ckeditor'
gem 'cocoon'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'carrierwave'
gem 'social-share-button'
```
y aplicar

```ruby
bundle install
```

Ahora se debe importar las migraciones del blog a Keppler-Admin y ejecutarlas.

```ruby
rake keppler_blog:install:migrations
rake db:migrate
```

Añadir la siguiente ruta a su archivo `routes.rb`

```ruby
mount KepplerBlog::Engine, :at => '/', as: 'blog'
```

Debe asignar los permisos de autorización para que pueda tener acceso a los módulos del blog, esto debe hacerlo desde el archivo `model/ability.rb`, aqui una muestra de como deben quedar las autorizaciones.

```ruby
if user.has_role? :admin
  can :manage, KepplerBlog::Post
  can :manage, KepplerBlog::Category
elsif user.has_role? :autor
  can :manage, KepplerBlog::Post, :user_id => user.id
elsif user.has_role? :editor
  can [:index, :update, :edit, :show]
end
```

Por defecto el blog esta desarrollado para trabajar con 3 roles de usuarios.

* **admin**: Tiene acceso completo a los módulos del blog.
* **autor**: Tiene acceso al módulo *POST* y solo se le permite aplicar acciones a los artículos(posts) de su propiedad.
* **edtir**: Tiene acceso al módulo *POST* y solo se le permite ver y editar cualquier artículo(post).


Añadir la siguiente linea a su manifesto stylesheets `admin/application.scss`

```ruby
@import "keppler_blog/admin/blog";
```

Añadir la siguiente linea a su manifesto stylesheets `frontend/application.scss`

```ruby
@import "keppler_blog/frontend/blog";
```

Añadir la siguiente linea a su manifesto javascripts `admin/application.coffee`

```ruby
#= require ckeditor/init
#= require cocoon
#= require keppler_blog/admin/application
```

Añadir la siguiente linea a su manifesto javascripts `froentend/application.coffee`

```ruby
#= require keppler_blog/frontend/application
```

## Configuración

##### Inicializador

Ejecutar `rake keppler_blog:copy_initializer`

```ruby
KepplerBlog.setup do |config|
	config.widget_twitter_id = "id" #widget timeline de twitter
	config.twitter_username = "username de twitter"
	config.facebook_app_id = "id" #comentarios de facebook para los posts
end
```

* Puede conseguir información de como obtener [widget_twitter_id](https://dev.twitter.com/web/embedded-timelines)
* Puede conseguir información de como obtener [facebook_app_id](https://developers.facebook.com/docs/plugins/comments)

##### Vistas

Para copiar las vistas a tu proyecto y asi personalizarlas, dejecutar

```ruby
rake keppler_blog:copy_views
```
