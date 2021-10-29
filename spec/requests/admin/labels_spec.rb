require 'rails_helper'

RSpec.describe 'Admin::labels', type: :request do

  before do
    @password = Faker::Internet.password
    @admin = User.create email: Faker::Internet.email,
                         name: Faker::Name.first_name,
                         password: @password,
                         password_confirmation: @password,
                         admin: true
    5.times do
      @label = Label.create name: Faker::Verb.base
    end
  end

  describe 'GET /admins/labels' do

    it 'not renders the admin labels template if not connected' do
      get admin_labels_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin label template if not admin' do
      @admin.update admin: false
      user = @admin
      post sessions_path, params: { session: { email: user.email, password: @password }}
      get admin_labels_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin labels template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get admin_labels_path
      expect(subject).to render_template('index')
    end
  end

  describe 'GET /admin/labels/:id' do

    it 'renders the admin label show template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get admin_label_path(@label)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET /admin/labels/:id/edit' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get edit_admin_label_path(@label)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PATCH /admin/labels/:id' do

    it 'edit name if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      label = Label.first
      new_name = Faker::Verb.base
      patch admin_label_path(label.id), params: { label: { name: new_name }}

      expect(Label.first.name).to eq(new_name)
    end
  end

  describe 'GET /admin/labels/new' do

    it 'renders the new template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get new_admin_label_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /admin/labels' do

    it 'create label if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      name = Faker::Name.first_name.downcase

      post admin_labels_path, params: { label: { name: name } }
      expect(Label.last.name).to eq(name)
    end
  end
end
