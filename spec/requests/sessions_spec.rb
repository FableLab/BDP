require 'rails_helper'

RSpec.describe 'Session', type: :request do
  before do
    @password = Faker::Internet.password
    @user = User.new email: Faker::Internet.email,
                     name: Faker::Name.first_name,
                     password: @password,
                     password_confirmation: @password
  end

  describe 'GET /sessions/new' do

    it 'renders the new template' do
      get new_sessions_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /session' do

    it 'logs in' do
      @user.save

      post sessions_path, params: { session: { email: @user.email, password: @password }}
      expect(controller).to be_logged_in
    end
  end

  describe 'DESTROY /sessions' do

    it 'logs out' do
      @user.save

      post sessions_path, params: { session: { email: @user.email, password: @password }}
      delete sessions_path
      expect(controller).not_to be_logged_in
    end
  end
end
