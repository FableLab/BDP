class Projet < ApplicationRecord
  after_initialize  :generate_slug
  before_validation :generate_slug, if: :will_save_change_to_name?

  after_initialize  :upcase_code
  before_validation :upcase_code, if: :will_save_change_to_code?

  validates :name,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true
  validates :slug,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true
  validates :code,  presence: true, length: { is: 2 }, uniqueness: true
  validates :description, length: { maximum: 25000 }

  before_save do
    self.name = self.name.humanize if self.name
  end

  def upcase_code
    self.code.upcase! if self.code
  end

  def generate_slug
    if name
      self.slug = self.name.downcase.parameterize separator: '_'
    end
  end
end
