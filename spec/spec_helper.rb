# frozen_string_literal: false

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'watir'
require 'headless'

require './init.rb'

<<<<<<< HEAD
require 'page-object'
require_relative 'pages/init'

=======
>>>>>>> rebase conflics resolved
HOST = 'http://localhost:3000'
IMAGE = File.expand_path('./spec/fixtures/demo-image.jpg').freeze
BADFILE = File.expand_path('./spec/fixtures/badfile.pdf').freeze

# helper methods
def homepage
  HOST
end
