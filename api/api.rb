# frozen_string_literal: true

require 'grape'
require 'securerandom'
require 'import'
require 'grape-swagger'

class Api < Grape::API
  format :json
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error! e.full_messages, 422
  end

  require 'rack/cors'
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :get
    end
  end

  URL_REGEXP = %r{http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+}.freeze

  desc 'The short link to the given resource' do
    summary 'Endpoint to create a shorter version of a given resource'
    detail 'Provide a url to the interested resource and it returns a shorter link to that resource'
    produces ['application/json']
    consumes ['application/json']
  end
  params do
    requires :link, type: String, desc: 'The link to the resource, wants to share', regexp: URL_REGEXP
  end
  post do
    key = SecureRandom.alphanumeric(10)
    App['store'].transaction { App['store'][key] = params[:link] }
    { link: URI.join(request.url, key) }
  end

  desc 'Redirect to a real link'
  params do
    requires :id, type: String, desc: 'Key to link'
  end
  route_param :id do
    get do
      link_to_redirect = App['store'].transaction(true) { App['store'][params[:id]] }

      return error!(:not_found, 404) if link_to_redirect.blank?

      redirect link_to_redirect
    end
  end

  add_swagger_documentation \
    mount_path: '/swagger/docs',
    info: {
      title: 'The short link API',
      description: 'This API creates a shorter version of a given link.',
      contact_name: 'Andrew Ageev',
      contact_email: 'ageev86@gmail.com',
      license: 'MIT',
      license_url: "https://opensource.org/licenses/MIT",
    }

end
