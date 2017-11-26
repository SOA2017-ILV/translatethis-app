# frozen_string_literal: false

folders = %w[representers services forms views]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end

require_relative 'app.rb'
