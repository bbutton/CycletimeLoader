class MetricsCard
  attr_reader :labels, :card_name, :card_id, :board_name, :actions, :board_id

  # what are field names to use to pull out this data?
  def initialize(card, board_name, actions)
    @card_id = card.id
    @card_name = card.name
    @board_id = card.board_id
    @board_name = board_name
    @actions = actions
    @labels = card.card_labels
  end
end