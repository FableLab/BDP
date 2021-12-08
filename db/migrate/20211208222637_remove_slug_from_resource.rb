class RemoveSlugFromResource < ActiveRecord::Migration[6.1]
  def change
    remove_column :resources, :slug
  end
end
