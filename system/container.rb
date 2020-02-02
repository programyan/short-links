# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/components'

class App < Dry::System::Container
  # configure do |config|
  #   config.auto_register = %w[api]
  # end

  load_paths!('api', 'system')
end
