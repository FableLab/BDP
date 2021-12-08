require 'rails_helper'

RSpec.describe 'Admin::resources', type: :request do

  before do
    @password = Faker::Internet.password
    @admin = User.create email: Faker::Internet.email,
                         name: Faker::Name.first_name,
                         password: @password,
                         password_confirmation: @password,
                         admin: true
    5.times do
      @projet = Projet.create name: Faker::Verb.base,
                              description: Faker::Lorem.paragraph_by_chars,
                              code: Faker::Lorem.characters(number: 2).upcase
      @label = Label.create name: Faker::Verb.base
      @category = Category.create name: Faker::Verb.base,
                                  code: Faker::Lorem.characters(number: 3).upcase
      @format = Format.create name: Faker::Verb.base,
                              code: Faker::Lorem.characters(number: 3).upcase,
                              group: 'autres'
      @resource = Resource.create code_number: '0001', code_language: 'eng', translation: 'car',
                                  projet: @projet, label: @label, category: @category, format: @format
    end
  end

  describe 'GET /admins/resources' do

    it 'not renders the admin resources template if not connected' do
      get admin_resources_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin resource template if not admin' do
      @admin.update admin: false
      user = @admin
      post sessions_path, params: { session: { email: user.email, password: @password }}
      get admin_resources_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin resources template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get admin_resources_path
      expect(subject).to render_template('index')
    end
  end

  describe 'GET /admin/resources/:id' do

    it 'renders the admin resource show template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get admin_resource_path(@resource)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET /admin/resources/:id/edit' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get edit_admin_resource_path(@resource)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PATCH /admin/resources/:id' do

    it 'edit label if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      @label = Label.create name: Faker::Verb.base
      patch admin_resource_path(Resource.first.id), params: { resource: { label_id: @label.id }}

      expect(Resource.first.label.id).to eq(@label.id)
    end
  end

  describe 'GET /admin/resources/new' do

    it 'renders the new template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get new_admin_resource_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /admin/resources' do

    it 'create resource if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      params = { code_number: '0002', code_language: 'ENG', translation: 'car',
                 projet_id: @projet.id, label_id: @label.id, category_id: @category.id, format_id: @format.id }

      post admin_resources_path, params: { resource: params }
      expect(Resource.last.translation).to eq(params[:translation])
      expect(Resource.last.code_language).to eq(params[:code_language])
      expect(Resource.last.code_number).to eq(params[:code_number])
    end
  end
end
