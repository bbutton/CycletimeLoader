require 'rspec'
require_relative '../lib/metrics_calculator'
require_relative '../lib/board_data_repository'

describe 'Calculates metrics' do

  it 'should do something' do
    board_data_repository = BoardDataRepository.new(ENV["TRELLO_DEV_KEY"], ENV["TRELLO_TOKEN"])
    board_data = board_data_repository.get_board_data('56cf79bf1614d0806209b94a')

    metrics_calculator = MetricsCalculator.new
    metrics_calculator.calculate_cycletime(board_data)

  end
end