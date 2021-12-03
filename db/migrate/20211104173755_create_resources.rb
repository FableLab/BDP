class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.boolean :published
      t.string :code_language
      t.string :code_number
      t.string :translation
      t.string :slug
      t.belongs_to :label, foreign_key: true
      t.belongs_to :projet, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.belongs_to :format, foreign_key: true

      t.timestamps
    end
  end
end
