require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do

  before do
    5.times do
      @password = Faker::Internet.password
      User.create email: Faker::Internet.email,
                  name: Faker::Name.first_name,
                  password: @password,
                  password_confirmation: @password
    end
    @admin = User.last
    @admin.update admin: true
  end

  describe 'GET /admins/users' do

    it 'not renders the admin users template if not connected' do
      get admin_users_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin users template if not admin' do
      @admin.update admin: false
      user = @admin

      post sessions_path, params: { session: { email: user.email, password: @password }}
      get admin_users_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin users template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      get admin_users_path
      expect(subject).to render_template('index')
    end
  end

  describe 'GET /admin/users/:id' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get admin_user_path(User.first)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET /admin/users/:id/edit' do

    it 'renders the admin users edit template if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}

      get edit_admin_user_path(User.first)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PATCH /admin/users/:id' do

    it 'edit name if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      user = User.first
      new_name = Faker::Name.first_name
      patch admin_user_path(user.id), params: { user: { name: new_name }}

      expect(User.first.name).to eq(new_name)
    end
  end

  describe 'DELETE /admin/users/:id' do

    it 'delete user if admin' do
      post sessions_path, params: { session: { email: @admin.email, password: @password }}
      id = User.first.id
      delete admin_user_path(User.find(id))

      expect(User.find_by(id: id)).to be_falsey
    end
  end
end
