# frozen_string_literal: true

App.boot :store do
  init do |container|
    require 'pstore'
    container.register('store', PStore.new('db/store.pstore'))
  end
end
