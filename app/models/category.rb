class Category < ApplicationRecord
  after_initialize  :upcase_code
  before_validation :upcase_code, if: :code_changed?

  validates :name,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true
  validates :code,  presence: true, length: { is: 3 }, uniqueness: true

  before_save do
    self.name = self.name.humanize if self.name
  end

  def upcase_code
    self.code.upcase! if self.code
  end
end
