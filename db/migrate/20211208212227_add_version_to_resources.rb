class AddVersionToResources < ActiveRecord::Migration[6.1]
  def change
    rename_column :resources, :code_number, :version
    change_column :resources, :version, :integer, using: 'version::integer'
  end
end
