# frozen_string_literal: true

require 'csv'
require 'uri'
require 'open-uri'

# Service that takes a file_name and returns a hash of mushroom data.
class MushRoomParser
  attr_reader :shrooms

  LETTERS_TO_COLOR = {
    n: 'brown',
    b: 'buff',
    c: 'cinnamon',
    g: 'gray',
    r: 'green',
    p: 'pink',
    u: 'purple',
    e: 'red',
    w: 'white',
    y: 'yellow'
  }.freeze

  def initialize(file_name:)
    @file_name = file_name
    @handler = @file_name.scan(URI::DEFAULT_PARSER.make_regexp).any? ? 'remote' : 'local'
    @shrooms = send("parse_#{handler}_file")
  end

  private

  def parse_remote_file
    @file = URI.open(@file_name)
    count_shrooms
  end

  def parse_local_file
    @file = File.join(__dir__, "../data/#{@file_name}")
    File.exist?(@file) ? count_shrooms : { error: 'File does not exist' }
  end

  def count_shrooms
    counted_shrooms = {}

    CSV.foreach(@file) do |row|
      color = LETTERS_TO_COLOR[row[3].to_sym]
      edible = row[0] == 'e'

      # We could alternatively use an OpenStruct here to mimic a regular object interface.
      # Its slower when doing lookup operations though, so lets stay with our more performant hash for now.
      counted_shrooms[color] = { edible: 0, non_edible: 0 } if counted_shrooms[color].nil?

      edible ? counted_shrooms[color][:edible] += 1 : counted_shrooms[color][:non_edible] += 1
    end
    counted_shrooms
  end
end
