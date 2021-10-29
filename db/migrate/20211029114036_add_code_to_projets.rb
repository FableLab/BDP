class AddCodeToProjets < ActiveRecord::Migration[6.1]
  def change
    add_column :projets, :code, :string
  end
end
