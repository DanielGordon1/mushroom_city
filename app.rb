# frozen_string_literal: true

require 'sinatra'
require_relative 'mushroom_parser.rb'

get '/' do
  erb :home
end

get '/shrooms' do
  @result = MushRoomParser.new("./#{params[:file_name]}")
                          .shrooms

  erb :index
end
