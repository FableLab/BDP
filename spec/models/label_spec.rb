require 'rails_helper'

RSpec.describe Label, type: :model do

  before do
    @label = Label.new name: Faker::Verb.base
  end

  it 'is valid with valid attributes' do
    expect(@label).to be_valid
  end

  it 'is generate automatically slug' do
    @label.update name: 'Fishing vessel'
    expect(@label.slug).to eq('fishing_vessel')
  end


  it 'is invalid without name' do
    @label.update name: nil
    expect(@label).to be_invalid
  end


  it 'is invalid with not uniq name' do
    @label.save
    other_label = Label.new name: @label.name
    expect(other_label).to be_invalid
  end
end
