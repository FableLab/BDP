require 'rails_helper'

RSpec.describe 'Admin', type: :request do

  before do
    @password = Faker::Internet.password
    @user = User.new email: Faker::Internet.email,
                     name: Faker::Name.first_name,
                     password: @password,
                     password_confirmation: @password
  end

  describe 'GET /admin' do

    it 'not renders the admin template if not connected' do
      get admin_index_path
      expect(subject).not_to render_template('index')
    end

    it 'not renders the admin template if not admin' do
      @user.admin = false
      @user.save

      post sessions_path, params: { session: { email: @user.email, password: @password }}
      get admin_index_path
      expect(subject).not_to render_template('index')
    end

    it 'renders the admin template if admin' do
      @user.admin = true
      @user.save

      post sessions_path, params: { session: { email: @user.email, password: @password }}
      get admin_index_path
      expect(subject).to render_template('index')
    end
  end
end
