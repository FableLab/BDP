class Format < ApplicationRecord
  enum group: { Illustrations: 'illustrations', Sons: 'sons', Documents: 'documents', Photos: 'photos', Autres: 'autres' }, _default: 'autres'

  after_initialize  :upcase_code
  before_validation :upcase_code, if: :code_changed?

  validates :name,  presence: true, length: { minimum: 2, maximum: 64 }, uniqueness: true
  validates :code,  presence: true, length: { is: 3 }, uniqueness: true

  before_save do
    self.name = name.slice(0,1).capitalize + name.slice(1..-1) if self.name
  end

  def upcase_code
    self.code.upcase! if self.code
  end
end
