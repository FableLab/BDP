class Resource < ApplicationRecord
  belongs_to :label
  belongs_to :projet, optional: true
  belongs_to :category, optional: true
  belongs_to :format, optional: true

  before_validation :formatting_attributes

  validates :code_number,  presence: true, length: { is: 4 }
  validates :code_language, presence: true, length: { is: 3 }
  validates :slug,  presence: true, length: { minimum: 18, maximum: 256 }, uniqueness: true

  def formatting_attributes
    formatting_code_number
    formatting_code_language
    generate_slug
  end

  def formatting_code_number
    self.code_number = (code_number || '1').rjust(4, '0')
  end

  def formatting_code_language
    self.code_language = 'XXX' unless self.code_language.present?
    self.code_language.upcase!
  end

  def generate_slug
    projet_code = projet.try(:code) || 'XX'
    category_code = category.try(:code) || 'XXX'
    format_code = format.try(:code)||'XXX'
    self.slug = "#{projet_code}-#{category_code}-#{format_code}-#{code_language}-#{code_number}-#{label.slug}" if label
  end
end
