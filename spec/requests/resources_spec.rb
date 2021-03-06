require 'rails_helper'

RSpec.describe 'Resources', type: :request do
  describe 'GET /resources' do

    it 'renders the home template' do
      get resources_path
      expect(subject).to render_template('index')
    end
  end


  describe 'GET /resources/:slug' do

    it 'renders the show' do
      @projet = Projet.create name: Faker::Verb.base,
                              description: Faker::Lorem.paragraph_by_chars,
                              code: Faker::Lorem.characters(number: 2).upcase
      @label = Label.create name: Faker::Verb.base
      @category = Category.create name: Faker::Verb.base,
                                  code: Faker::Lorem.characters(number: 3).upcase
      @format = Format.create name: Faker::Verb.base,
                              code: Faker::Lorem.characters(number: 3).upcase,
                              group: 'autres'
      @resource = Resource.create code_language: 'ENG', translation: 'car',
                                  projet: @projet, label: @label, category: @category, format: @format

      get resource_path(slug: @resource.slug)
      expect(subject).to render_template('show')
    end
  end
end
