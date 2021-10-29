require 'rails_helper'

RSpec.describe 'Admin::projets', type: :request do

  before do
    @password = Faker::Internet.password
    @admin = User.create email: Faker::Internet.email,
                         name: Faker::Name.first_name,
                         password: @password,
                         password_confirmation: @password,
                         admin: true
    5.times do
      @projet = Projet.create name: Faker::Verb.base, description: Faker::Lorem.paragraph_by_chars
    end
  end

  describe 'GET /admins/projets' do

    it 'not renders the admin projets template if not connected' do
      get admin_projets_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin projet template if not admin' do
      @admin.update admin: false
      user = @admin
      post sessions_path, params: { session: { email: user.email, password: @password }}
      get admin_projets_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin projets template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get admin_projets_path
      expect(subject).to render_template('index')
    end
  end

  describe 'GET /admin/projets/:id' do

    it 'renders the admin projet show template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get admin_projet_path(@projet)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET /admin/projets/:id/edit' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get edit_admin_projet_path(@projet)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PATCH /admin/projets/:id' do

    it 'edit name if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      new_name = Faker::Verb.base
      patch admin_projet_path(Projet.first.id), params: { projet: { name: new_name }}

      expect(Projet.first.name).to eq(new_name)
    end
  end

  describe 'GET /admin/projets/new' do

    it 'renders the new template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get new_admin_projet_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /admin/projets' do

    it 'create projet if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      params = { name: Faker::Name.first_name.downcase, description: Faker::Lorem.paragraph_by_chars }

      post admin_projets_path, params: { projet: params }
      expect(Projet.last.name).to eq(params[:name])
      expect(Projet.last.description).to eq(params[:description])
    end
  end
end
