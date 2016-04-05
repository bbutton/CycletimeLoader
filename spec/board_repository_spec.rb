require 'rspec'
require_relative '../lib/board_repository'

describe 'Basic operations' do

  it 'should retrieve single board id' do
    board_repository = BoardRepository.new(
        'aatc-demo.il1.rdbs.ctl.io',
        49964,
        'bbutton-aatc',
        '{L1ns3y1994}',
        'AATC-Demo'
    )

    board_id = board_repository.find_board_to_load
    expect(board_id).to eq("53fb794a72ab28b254f3f471")
  end
end