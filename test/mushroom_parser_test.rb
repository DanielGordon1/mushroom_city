# frozen_string_literal: true

require_relative '../services/mushroom_parser.rb'

require 'minitest/autorun'

class MushRoomParserTest < Minitest::Test
  def test_it_raises_an_error_when_not_passed_named_argument
    assert_raises(ArgumentError) { MushRoomParser.new('a_file_name') }
  end

  def test_it_does_not_raise_an_error_with_non_existing_file_name
    service = MushRoomParser.new(file_name: 'this_is_not_file_you_are_looking_for.csv')
    assert_instance_of(MushRoomParser, service)
    assert_equal({ error: 'File does not exist' }, service.shrooms)
  end

  def test_it_returns_a_hash_of_shroom_data_for_valid_file_names
    service = MushRoomParser.new(file_name: 'agaricus-lepiota.data')
    assert_equal({ edible: 1264, non_edible: 1020 }, service.shrooms['brown'])
  end

  describe '#count_shrooms' do
    def test_it_raises_a_no_method_error_when_invoked
      service = MushRoomParser.new(file_name: 'file.data')

      assert_raises(NoMethodError) { service.count_shrooms }
    end

    def test_it_returns_a_hash_of_data_when_invoked_using_send
      service = MushRoomParser.new(file_name: 'agaricus-lepiota.data')
      result = service.send(:count_shrooms)

      assert_instance_of(Hash, result)
      assert_equal(MushRoomParser::LETTERS_TO_COLOR.values.sort, result.keys.sort)
      assert_equal({ edible: 400, non_edible: 672 }, result['yellow'])
    end
  end
end
