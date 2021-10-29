require 'rails_helper'

RSpec.describe Projet, type: :model do

  before do
    @projet = Projet.new name: Faker::Verb.base, description: Faker::Lorem.paragraph_by_chars
  end

  it 'is valid with valid attributes' do
    expect(@projet).to be_valid
  end

  it 'is generate automatically slug' do
    @projet.update name: 'Atelier écriture'
    expect(@projet.slug).to eq('atelier_ecriture')
  end


  it 'is invalid without name' do
    @projet.update name: nil
    expect(@projet).to be_invalid
  end


  it 'is invalid with not uniq name' do
    @projet.save
    other_projet = Projet.new name: @projet.name
    expect(other_projet).to be_invalid
  end
end
