require 'sinatra'
require_relative 'mushroom_parser.rb'

get '/shrooms' do
  @result = MushRoomParser.new('./agaricus-lepiota.data')

  erb :index
end
