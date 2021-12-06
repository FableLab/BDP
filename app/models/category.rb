class Category < ApplicationRecord
  has_many :resources
  after_initialize  :upcase_code
  before_validation :upcase_code, if: :code_changed?
  after_update :update_resource_slug

  validates :name,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true
  validates :code,  presence: true, length: { is: 3 }, uniqueness: true

  before_save do
    self.name = self.name.humanize if self.name
  end

  def upcase_code
    self.code.upcase! if self.code
  end

  def update_resource_slug
    self.resources.each { |r| r.generate_slug! }
  end
end
