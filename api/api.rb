# frozen_string_literal: true

require 'grape'
require 'securerandom'
require 'import'

class Api < Grape::API
  format :json

  desc 'Create a short link'
  params do
    requires :link, type: String, desc: 'Link'
  end
  post do
    key = SecureRandom.alphanumeric(10)
    App['store'].transaction do
      App['store'][key] = params[:link]
    end
    { link: URI.join(request.url, key) }
  end

  desc 'Redirect to a real link'
  params do
    requires :id, type: String, desc: 'Key to link'
  end
  route_param :id do
    get do
      App['store'].transaction(true) do
        redirect App['store'][params[:id]]
      end
    end
  end
end
