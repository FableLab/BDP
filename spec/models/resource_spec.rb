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
end
