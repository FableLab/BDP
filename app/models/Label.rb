class Label < ApplicationRecord
  has_many :resources
  after_initialize :generate_slug
  before_validation :generate_slug, if: :will_save_change_to_name?
  after_update :update_resource_slug

  validates :name,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true
  validates :slug,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true

  def generate_slug
    if name
      self.name.downcase!
      self.slug = self.name.parameterize separator: '_'
    end
  end

  def update_resource_slug
    self.resources.each { |r| r.rename_file! }
  end
end
