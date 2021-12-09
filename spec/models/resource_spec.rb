require 'rails_helper'

RSpec.describe Resource, type: :model do
  before do
    @label = Label.create name: 'voiture'
    @resource = Resource.new version: 1, code_language: 'ENG', translation: 'car', label: @label
  end

  it 'is valid with valid attributes' do
    expect(@resource).to be_valid
  end

  it 'is generate automatically slug' do
    @resource.save
    expect(@resource.slug).to eq("XX-XXX-XXX-ENG-#{@resource.code_number}-01-#{@label.slug}")
  end

  it 'is generate automatically code_number' do
    @resource.save
    expect(@resource.code_number.size).to be(4)
    expect(@resource.slug).to eq("XX-XXX-XXX-ENG-#{@resource.code_number}-01-#{@label.slug}")
  end


  it 'is find resource by code number formatted' do
    @resource.save
    code_number = @resource.code_number
    id = Resource.find_by_code_number(code_number).id

    expect(id).to eq(@resource.id)
  end

  it 'rename filename automatically with new slug if projet, category or format is edited' do
    # @projet = Projet.create name: Faker::Verb.base,
    #                      description: Faker::Lorem.paragraph_by_chars,
    #                      code: Faker::Lorem.characters(number: 2).upcase
    #
    # @category = Category.create name: Faker::Verb.base,
    #                             code: Faker::Lorem.characters(number: 3).upcase
    #
    # @format = Format.create name: Faker::Verb.base,
    #                         code: Faker::Lorem.characters(number: 3).upcase,
    #                         group: ['illustrations']
    #
    # @label = Label.create name: Faker::Verb.base
    #
    # @resource.update projet_id: @projet.id,
    #                   category_id: @category.id,
    #                   format_id: @format.id,
    #                   label_id: @label.id
    #
    # @projet.update(code: 'PR')
    # @category.update(code: 'CAT')
    # @format.update(code: 'FOR')
    # @label.update(name: 'test')
    # @resource.reload
    # expect(@resource.file.blob.filename).to eq("PR-CAT-FOR-#{@resource.code_number}-01-test")
  end
end
