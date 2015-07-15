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

    validates_presence_of :title, :body, :category
    validates_uniqueness_of :title

    def self.searching(query)
      if query
        self.search(self.query query).records.order(id: :desc)
      else
        self.order(id: :desc)
      end
    end

    def self.query(query)
      { query: { multi_match:  { query: query, fields: [] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        title:  self.title.to_s,
        body:  self.body.to_s,
        user_id:  self.user_id.to_s,
        category_id:  self.category_id.to_s,
        subcategory_id:  self.subcategory_id.to_s,
        image:  self.image.to_s,
        public:  self.public.to_s,
        comments_open:  self.comments_open.to_s,
        shared_enabled:  self.shared_enabled.to_s,
        permalink:  self.permalink.to_s,
      }.as_json
    end

    private

    def create_permalink
      self.permalink = self.title.downcase.parameterize
    end

  end
  #Post.import
end
