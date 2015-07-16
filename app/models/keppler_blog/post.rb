#Generado por keppler
require 'elasticsearch/model'
module KepplerBlog
  class Post < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    before_save :create_permalink
    mount_uploader :image, ImageUploader
    belongs_to :user
    belongs_to :category
    belongs_to :subcategory
    acts_as_taggable
    acts_as_taggable_on :tags
    
    validates_presence_of :title, :body, :category
    validates_uniqueness_of :title

    def self.filter_by_autor(autor)
       where(public: true, user: User.find_by_permalink(autor).id)
    end

    def self.filter_by_category(category)
      where(public: true, category: Category.find_by_permalink(category).id)
    end

    def self.filter_by_subcategory(category, subcategory)
      Category.find_by_permalink(category).subcategories.find_by_permalink(subcategory).posts
    end

    def self.searching(query)
      if query
        self.search(self.query query).records.order(id: :desc)
      else
        self.order(id: :desc)
      end
    end

    def self.query(query)
      { query: { multi_match:  { query: query, fields: [:id, :title, :body, :category, :subcategory, :public, :comments, :shared] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        title:  self.title,
        body:  ActionView::Base.full_sanitizer.sanitize(self.body, tags: []),
        user_id:  self.user.name,
        category:  self.category.name,
        subcategory:  self.subcategory ? self.subcategory.name : "--subcategoria",
        public:  self.public ? "Publicado" : "--publicado",
        comments:  self.comments_open ? "Comentarios" : "--comentarios",
        shared:  self.shared_enabled ? "Compartiendo redes" : "--compartiendo redes",
      }.as_json
    end

    private

    def create_permalink
      self.permalink = self.title.downcase.parameterize
    end

  end
  #Post.import
end
