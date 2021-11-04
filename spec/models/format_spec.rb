require 'rails_helper'

RSpec.describe Format, type: :model do

  before do
    @format = Format.new name: Faker::Verb.base,
                         code: Faker::Lorem.characters(number: 3).upcase,
                         group: ['illustrations', 'sons', 'documents', 'photos', 'autres'].sample
  end

  it 'is valid with valid attributes' do
    expect(@format).to be_valid
  end

  it 'is upcase automatically code' do
    @format.update code: 'mem'
    expect(@format.code).to eq('MEM')
  end

  it 'is invalid without name' do
    @format.update name: nil
    expect(@format).to be_invalid
  end

  it 'is invalid without code' do
    @format.update code: nil
    expect(@format).to be_invalid
  end

  it 'is invalid with not uniq name' do
    @format.save
    other_format = Format.new name: @format.name,
                              code: Faker::Lorem.characters(number: 3).upcase,
                              group: 'autres'
    expect(other_format).to be_invalid
  end

  it 'is invalid with not uniq code' do
    @format.save
    other_format = Format.new name: Faker::Verb.base,
                              code: @format.code,
                              group: 'autres'
    expect(other_format).to be_invalid
  end
end
