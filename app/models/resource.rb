class Resource < ApplicationRecord
  has_one_attached :file
  belongs_to :label
  belongs_to :projet, optional: true
  belongs_to :category, optional: true
  belongs_to :format, optional: true

  before_validation :formatting_attributes
  before_save :rename_file
  validates :file, attached: true, content_type: [:jpg, :jpeg], size: { less_than: 3.megabytes },
                                   if: -> { format.try(:group) == 'Photos' }
  validates :file, attached: true, content_type: [:png, :jpg, :jpeg, :gif], size: { less_than: 3.megabytes },
                                   if: -> { format.try(:group) == 'Illustrations' }
  validates :file, attached: true, content_type: ['audio/mpeg'], size: { less_than: 100.megabytes },
                                   if: -> { format.try(:group) == 'Sons' }

  validates :code_number,  presence: true, length: { is: 4 }
  validates :code_language, presence: true, length: { is: 3 }
  validates :slug,  presence: true, length: { minimum: 18, maximum: 256 }, uniqueness: true

  def file_extension
    self.file.filename.extension
  end

  def rename_file
    file.blob.update!(filename: "#{slug}.#{file_extension}") if file.present?
  end

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
    if label
      self.slug = "#{projet_code}-#{category_code}-#{format_code}-#{code_language}-#{code_number}-#{label.slug}"
    end
  end

  def generate_slug!
    generate_slug
    save
    rename_file
  end
end
