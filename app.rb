require 'sinatra'
require_relative 'mushroom_parser.rb'

get '/shrooms/:file_name' do
  @result = MushRoomParser.new("./#{params[:file_name]}")
                          .shrooms

  erb :index
end
