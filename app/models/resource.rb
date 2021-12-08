class Resource < ApplicationRecord
  has_one_attached :file
  belongs_to :label
  belongs_to :projet, optional: true
  belongs_to :category, optional: true
  belongs_to :format, optional: true

  attr_default :code_language, 'XXX'
  attr_default :version, 1

  before_validation :remove_translation_spaces
  after_save :rename_file

  validates :file, attached: true, content_type: [:jpg, :jpeg], size: { less_than: 3.megabytes },
                                   if: -> { format.try(:group) == 'Photos' }
  validates :file, attached: true, content_type: [:png, :jpg, :jpeg, :gif], size: { less_than: 3.megabytes },
                                   if: -> { format.try(:group) == 'Illustrations' }
  validates :file, attached: true, content_type: ['audio/mpeg'], size: { less_than: 100.megabytes },
                                   if: -> { format.try(:group) == 'Sons' }

  validates :version,  presence: true
  validates :code_language, presence: true, length: { is: 3 }
  #validates :slug,  presence: true, length: { minimum: 18, maximum: 256 }, uniqueness: true

  def remove_translation_spaces
    if translation.present?
      translation.rstrip!
      translation.lstrip!
    end
  end

  def file_extension
    self.file.filename.extension
  end

  def rename_file
    file.blob.update!(filename: "#{slug}.#{file_extension}") if file.present?
  end

  def code_number
    if id
      id.to_s(36).upcase.rjust(4, '0')
    else
      'XXXX'
    end
  end

  def self.find_by_code_number(code_number_critera)
    find code_number_critera.to_i(36)
  end

  def version_formatted
    version.to_s.rjust(2, '0')
  end

  def slug
    projet_code = projet.try(:code) || 'XX'
    category_code = category.try(:code) || 'XXX'
    format_code = format.try(:code)||'XXX'
    "#{projet_code}-#{category_code}-#{format_code}-#{code_language.upcase}-#{code_number}-#{version_formatted}-#{label.slug}"
  end
end
