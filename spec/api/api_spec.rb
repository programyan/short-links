# frozen_string_literal: true

require 'spec_helper'

describe Api do
  include Rack::Test::Methods

  def app
    Api
  end

  describe 'GET :id' do
    before { get "/#{id}" }

    context 'without id' do
      let(:id) { nil }

      it { expect(last_response.status).to eq(405) }
    end

    context 'with invalid id' do
      let(:id) { '-xyz' }

      it { expect(last_response.status).to eq(404) }
    end

    context 'without id' do
      let(:id) do
        key = SecureRandom.alphanumeric(10)
        App['store'].transaction { App['store'][key] = 'http://example.com' }
        key
      end

      it { expect(last_response.status).to eq(302) }
    end
  end

  describe 'POST /' do
    before { post '/', params.to_json, 'CONTENT_TYPE' => 'application/json' }

    let(:params) { { link: link } }

    context 'with invalid link' do
      let(:link) { 'examplecom' }

      it { expect(last_response.status).to eq 422 }

      it { expect(JSON.parse(last_response.body)['error']).to include 'link is invalid' }
    end

    context 'with valid link' do
      let(:link) { 'http://example.com' }

      it { expect(last_response.status).to eq 201 }
    end
  end

  describe 'Swagger Documentation' do
    before { get '/swagger/docs' }

    it { expect(last_response.status).to eq 200 }
  end
end
