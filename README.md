### Keppler Blog 

Engine que integra un blog a Keppler-Admin.

## Dependencias

* [ckeditor](https://github.com/galetahub/ckeditor)
* [cocoon](https://github.com/nathanvda/cocoon)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
* [social-share-button](https://github.com/huacnlee/social-share-button)

## Requerimientos

* Keppler-Admin >= 1.0.0

### Instalación

Añadir a su Gemfile

```ruby
gem 'keppler_blog', git: 'https://github.com/inyxtech/Keppler-Blog.git'
gem 'ckeditor'
gem 'cocoon'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'carrierwave'
gem 'social-share-button'
```

Añadir la siguiente linea a su manifesto stylesheets `application.scss`

```ruby
@import 'dashboard'
```

Añadir la siguiente ruta a su archivo `routes.rb`

```ruby
mount KepplerGaDashboard::Engine, :at => '', as: 'dashboard'
```

### Configuración

El engine necesita que el usuario cree una api para google analitycs, esto lo puedes conseguir desde (https://console.developers.google.com), debes crear un  proyecto, luego crear un cliente y selecionar la opción **cuenta de servicio**, una vez creado hay que generar una calve p12 y guardar el archivo en el directorio `config/gaAuth` de su app.

Luego de haber realizado esto debe agregar los datos de configuración en `secrets.yml` bajo la siguiente configuracion:

```yml
ga_auth:
  :service_account_email_address: "dirección de correo electronico generada por la api"
  :file_key_name: "nombre del archio p12 generado por la api"
```

**Nota:** *Asegurese de darle permisos a la api desde su cuenta de google analitycs*

### Vista

Para copiar las vista a tu proyecto y asi personalizarlas para adaptarlas y agregar nuevos reportes, debe ejecutar

```ruby
rake dashboard:copy_views
```
