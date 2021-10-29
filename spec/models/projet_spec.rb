require 'rails_helper'

RSpec.describe Projet, type: :model do

  before do
    @projet = Projet.new name: Faker::Verb.base,
                         description: Faker::Lorem.paragraph_by_chars,
                         code: Faker::Lorem.characters(number: 2).upcase
  end

  it 'is valid with valid attributes' do
    expect(@projet).to be_valid
  end

  it 'is generate automatically slug' do
    @projet.update name: 'Atelier écriture'
    expect(@projet.slug).to eq('atelier_ecriture')
  end

  it 'is upcase automatically code' do
    @projet.update code: 'tt'
    expect(@projet.code).to eq('TT')
  end

  it 'is invalid without name' do
    @projet.update name: nil
    expect(@projet).to be_invalid
  end

  it 'is invalid without code' do
    @projet.update code: nil
    expect(@projet).to be_invalid
  end

  it 'is invalid with not uniq name' do
    @projet.save
    other_projet = Projet.new name: @projet.name
    expect(other_projet).to be_invalid
  end

  it 'is invalid with not uniq code' do
    @projet.save
    other_projet = Projet.new code: @projet.code
    expect(other_projet).to be_invalid
  end
end
