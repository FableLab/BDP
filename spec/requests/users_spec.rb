require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /users/new' do

    it 'renders the new template' do
      get new_user_path
      expect(subject).to render_template('new')
    end
  end

  describe 'CREATE /users/new' do

    it 'create user' do
      password = Faker::Internet.password

      expect {
        post users_path, params: { user: { email: Faker::Internet.email,
                                           name: Faker::Name.first_name,
                                           password: password,
                                           password_confirmation: password }
                                 }
      }.to change(User, :count).by(1)
    end
  end
end
