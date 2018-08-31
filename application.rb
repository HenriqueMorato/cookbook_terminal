require_relative 'cookbook'
require_relative 'receita'
require_relative 'file_saver'
require 'byebug'

module Application
  Cookbook.new.start
end
