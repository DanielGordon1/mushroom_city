require 'sinatra'
require_relative 'mushroom_parser.rb'

get '/shrooms' do
  service = MushRoomParser.new('./agaricus-lepiota.data')

  @result = service.count_shrooms

  erb :index
end
