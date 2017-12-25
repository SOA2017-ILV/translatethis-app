# frozen_string_literal: false

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'watir'
require 'headless'
require 'yaml'

require './init.rb'

require 'page-object'

require_relative 'pages/init'

HOST = 'http://localhost:3000'.freeze
IMAGE = File.expand_path('./spec/fixtures/demo-image.jpg').freeze
BADFILE = File.expand_path('./spec/fixtures/badfile.pdf').freeze
EXPECTED = YAML.safe_load(File.open('./spec/fixtures/expectedtranslation.yml'))
TRA_VAL = []
ORI_VAL = []

EXPECTED['translations'].map do |a|
  TRA_VAL.push(a['translation'])
  ORI_VAL.push(a['source'])
end
TRA_VAL.freeze
ORI_VAL.freeze

# helper methods
def homepage
  HOST
end
