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
end
