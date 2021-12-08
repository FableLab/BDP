require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do

    it 'renders the home template' do
      get '/presentation'
      expect(subject).to render_template('presentation')
    end
  end
end
