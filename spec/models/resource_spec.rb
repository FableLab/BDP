require 'rails_helper'

RSpec.describe Resource, type: :model do
  before do
    @label = Label.create name: 'voiture'
    @resource = Resource.new code_number: '0001', code_language: 'eng', translation: 'car', label: @label
  end

  it 'is valid with valid attributes' do
    expect(@resource).to be_valid
  end

  it 'is generate automatically slug' do
    @resource.save
    expect(@resource.slug).to eq("XX-XXX-XXX-ENG-0001-#{@label.slug}")
  end

  it 'is generate automatically code_number' do
    @resource.code_number = nil
    @resource.save
    expect(@resource.slug).to eq("XX-XXX-XXX-ENG-0001-#{@label.slug}")
  end

  it 'is invalid with not uniq slug' do
    @resource.save
    other_resource = Resource.new code_number: '0001', code_language: 'eng', translation: 'car', label: @label
    expect(other_resource).to be_invalid
  end

  it 'generate automatically new slug if projet, category or format is edited' do
    @projet = Projet.create name: Faker::Verb.base,
                         description: Faker::Lorem.paragraph_by_chars,
                         code: Faker::Lorem.characters(number: 2).upcase

    @category = Category.create name: Faker::Verb.base,
                                code: Faker::Lorem.characters(number: 3).upcase

    @format = Format.create name: Faker::Verb.base,
                            code: Faker::Lorem.characters(number: 3).upcase,
                            group: 'autres'

    @label = Label.create name: Faker::Verb.base

    @resource.update projet_id: @projet.id,
                      category_id: @category.id,
                      format_id: @format.id,
                      label_id: @label.id

    @projet.update(code: 'PR')
    @category.update(code: 'CAT')
    @format.update(code: 'FOR')
    @format.update(code: 'FOR')
    @label.update(name: 'test')
    @resource.reload

    expect(@resource.slug[0..1]).to eq('PR')
    expect(@resource.slug[3..5]).to eq('CAT')
    expect(@resource.slug[7..9]).to eq('FOR')
    expect(@resource.slug[20..100]).to eq('test')
  end
end
