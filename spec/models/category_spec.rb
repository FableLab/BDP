require 'rails_helper'

RSpec.describe Category, type: :model do

  before do
    @category = Category.new name: Faker::Verb.base,
                             code: Faker::Lorem.characters(number: 3).upcase
  end

  it 'is valid with valid attributes' do
    expect(@category).to be_valid
  end

  it 'is upcase automatically code' do
    @category.update code: 'tst'
    expect(@category.code).to eq('TST')
  end

  it 'is invalid without name' do
    @category.update name: nil
    expect(@category).to be_invalid
  end

  it 'is invalid without code' do
    @category.update code: nil
    expect(@category).to be_invalid
  end

  it 'is invalid with not uniq name' do
    @category.save
    other_category = Category.new name: @category.name, code: Faker::Lorem.characters(number: 3).upcase
    expect(other_category).to be_invalid
  end

  it 'is invalid with not uniq code' do
    @category.save
    other_category = Category.new name: Faker::Verb.base, code: @category.code
    expect(other_category).to be_invalid
  end
end
