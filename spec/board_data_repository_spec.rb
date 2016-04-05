require 'rspec'
require_relative '../lib/board_data_repository'

describe 'Retrieves cards' do

  it 'should get all cards' do
    board_data_repository = BoardDataRepository.new(ENV["TRELLO_DEV_KEY"], ENV["TRELLO_TOKEN"])
    board_data = board_data_repository.get_board_data('553fb2e24846c57c14e06ba9')
  end
end