class CreateProjets < ActiveRecord::Migration[6.1]
  def change
    create_table :projets do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
