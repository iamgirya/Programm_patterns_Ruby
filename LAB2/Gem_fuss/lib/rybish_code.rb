# frozen_string_literal: true

require_relative "rybish_code/version"

module RybishCode
  Dir[File.dirname(__FILE__) + '/source/**/*.rb'].each { |file|
    puts file
    require file
  }
end
