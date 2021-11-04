require 'rails_helper'

RSpec.describe 'Admin::formats', type: :request do

  before do
    @password = Faker::Internet.password
    @admin = User.create email: Faker::Internet.email,
                         name: Faker::Name.first_name,
                         password: @password,
                         password_confirmation: @password,
                         admin: true
    5.times do
      @format = Format.create name: Faker::Verb.base,
                              code: Faker::Lorem.characters(number: 3).upcase,
                              group: ['illustrations', 'sons', 'documents', 'photos', 'autres'].sample
    end
  end

  describe 'GET /admins/formats' do

    it 'not renders the admin formats template if not connected' do
      get admin_formats_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin format template if not admin' do
      @admin.update admin: false
      user = @admin
      post sessions_path, params: { session: { email: user.email, password: @password }}
      get admin_formats_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin formats template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get admin_formats_path
      expect(subject).to render_template('index')
    end
  end

  describe 'GET /admin/formats/:id' do

    it 'renders the admin format show template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get admin_format_path(@format)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET /admin/formats/:id/edit' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get edit_admin_format_path(@format)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PATCH /admin/formats/:id' do

    it 'edit name if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      new_name = Faker::Verb.base
      patch admin_format_path(Format.first.id), params: { format: { name: new_name }}

      expect(Format.first.name).to eq(new_name.humanize)
    end
  end

  describe 'GET /admin/formats/new' do

    it 'renders the new template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get new_admin_format_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /admin/formats' do

    it 'create format if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      params = { name: Faker::Verb.base,
                 code: Faker::Lorem.characters(number: 3).upcase,
                 group: ['illustrations', 'sons', 'documents', 'photos', 'autres'].sample }

      post admin_formats_path, params: { format: params }
      expect(Format.last.name).to eq(params[:name].humanize)
    end
  end
end
