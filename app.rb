# frozen_string_literal: true

require 'sinatra'
require_relative './services/mushroom_parser.rb'

get '/' do
  erb :home
end

get '/shrooms' do
  @result = MushRoomParser.new(file_name: params[:file_name])
                          .shrooms

  erb :index
end

if ENV['RACK_ENV'] == 'production'
  get '*' do
    redirect '/'
  end
end
