require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do
    
    it 'renders the home template' do
      get root_path
      expect(subject).to render_template('home')
    end
  end
end
