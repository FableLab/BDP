require 'rails_helper'

RSpec.describe 'Admin::Categories', type: :request do

  before do
    @password = Faker::Internet.password
    @admin = User.create email: Faker::Internet.email,
                         name: Faker::Name.first_name,
                         password: @password,
                         password_confirmation: @password,
                         admin: true
    5.times do
      @category = Category.create name: Faker::Verb.base,
                                  code: Faker::Lorem.characters(number: 3).upcase
    end
  end

  describe 'GET /admins/categories' do

    it 'not renders the admin categories template if not connected' do
      get admin_categories_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin category template if not admin' do
      @admin.update admin: false
      user = @admin
      post sessions_path, params: { session: { email: user.email, password: @password }}
      get admin_categories_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin categories template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get admin_categories_path
      expect(subject).to render_template('index')
    end
  end

  describe 'GET /admin/categories/:id' do

    it 'renders the admin category show template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get admin_category_path(@category)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET /admin/categories/:id/edit' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get edit_admin_category_path(@category)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PATCH /admin/categories/:id' do

    it 'edit name if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      new_name = Faker::Verb.base
      patch admin_category_path(Category.first.id), params: { category: { name: new_name }}

      expect(Category.first.name).to eq(new_name)
    end
  end

  describe 'GET /admin/categories/new' do

    it 'renders the new template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get new_admin_category_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /admin/categories' do

    it 'create category if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      params = { name: Faker::Verb.base,
                 code: Faker::Lorem.characters(number: 3).upcase }

      post admin_categories_path, params: { category: params }
      expect(Category.last.name).to eq(params[:name])
    end
  end
end
