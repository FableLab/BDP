require 'rails_helper'

RSpec.describe 'QrCodes', type: :request do

  describe 'GET /qrcodes/:id' do

    it 'renders QR code' do
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

      get qrcode_path(slug: @resource.slug, format: "png")

      expect(response.header["Content-Type"]).to eq('image/png')
    end
  end

  describe 'GET /qrcodes?:ids' do

    it 'renders QR code' do
      @projet = Projet.create name: Faker::Verb.base,
                              description: Faker::Lorem.paragraph_by_chars,
                              code: Faker::Lorem.characters(number: 2).upcase
      @label = Label.create name: Faker::Verb.base
      @category = Category.create name: Faker::Verb.base,
                                  code: Faker::Lorem.characters(number: 3).upcase
      @format = Format.create name: Faker::Verb.base,
                              code: Faker::Lorem.characters(number: 3).upcase,
                              group: 'autres'

      ['car', 'computer', 'plane'].each do |word|
        @resource = Resource.create code_language: 'ENG', translation: word,
                                    projet: @projet, label: @label, category: @category, format: @format
      end

      get qrcodes_path(ids: Resource.ids)

      expect(response.header["Content-Type"]).to eq('application/zip')
    end
  end
end
