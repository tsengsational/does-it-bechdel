ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end
