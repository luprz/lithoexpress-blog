class CreateKepplerBlogCategories < ActiveRecord::Migration
  def change
    create_table :keppler_blog_categories do |t|
      t.string :name
      t.string :permalink

      t.timestamps null: false
    end
  end
end
