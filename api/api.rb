# frozen_string_literal: true

require 'grape'
require 'securerandom'
require 'import'

class Api < Grape::API
  format :json
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error! e.full_messages, 422
  end

  URL_REGEXP = %r{http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+}.freeze

  desc 'Get a short link to the given resource'
  params do
    requires :link, type: String, desc: 'Link to the resource', regexp: URL_REGEXP
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
end
