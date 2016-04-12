require 'trello'

class BoardDataRepository
  def initialize(trello_dev_key, trello_token)
    @trello_dev_key = trello_dev_key
    @trello_token = trello_token

    Trello.configure do |config|
      config.developer_public_key =  @trello_dev_key # The "key" from step 1
      config.member_token =  @trello_token
    end
  end

  def get_board_data(board_id_to_load)
    board = Trello::Board.find(board_id_to_load)
    all_cards = board.cards(:filter => 'all')
    puts "#{all_cards.count} total cards found for #{board_id_to_load}"

    i = 0
    completed_cards = all_cards.select do |card|
      actions = card.actions
      working_count = actions.count{ |a| a.data["listAfter"] && a.data["listAfter"]["name"] == "Working" }
      complete_count = actions.count{ |a| a.data["listAfter"] && a.data["listAfter"]["name"] == "Complete" }
      puts "#{card.name}: Working: #{working_count}, Complete: #{complete_count}"
      STDOUT.flush

      i += 1
      if(i == 20) # Rate limiting :(
        puts "Hack for trello rate limiting..."
        sleep(3)
        i = 0
      end

      working_count > 0 && complete_count > 0
    end

    puts "#{completed_cards.count} cards completed."

    completed_cards
  end
end
