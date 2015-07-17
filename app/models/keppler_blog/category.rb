#Generado por keppler
require 'elasticsearch/model'
module KepplerBlog
  class Category < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    before_save :create_permalink
    has_many :posts, dependent: :destroy
    has_many :subcategories
    accepts_nested_attributes_for :subcategories, :reject_if => :all_blank, :allow_destroy => true

    #actualizar document de elasticsearch (ojo: no sabemos si es la mejor solucion.)
    #se deberia usar __elasticsearch__.update_document pero aparantemente no funciona.
    after_commit on: [:update] do
      puts __elasticsearch__.index_document
    end

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
        name:  self.name.to_s,
        permalink:  self.permalink.to_s,
      }.as_json
    end

    private

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

  end
  #Category.import
end
