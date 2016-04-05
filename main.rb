require_relative './lib/board_repository'
require_relative './lib/board_data_repository'
require_relative './lib/metrics_repository'
require_relative './lib/metrics_calculator'

db_host = ENV["DB_HOST"]
db_port = ENV["DB_PORT"]
db_user = ENV["DB_USER"]
db_password = ENV["DB_PASSWORD"]
db_name = ENV["DB_NAME"]

trello_dev_key = ENV["TRELLO_DEV_KEY"]
trello_token = ENV["TRELLO_TOKEN"]

orchestrate_api_key = ENV["ORCHESTRATE_API_KEY"]
orchestrate_collection = ENV["ORCHESTRATE_COLLECTION"]
orchestrate_endpoint = ENV["ORCHESTRATE_ENDPOINT"]

board_repository = BoardRepository.new(db_host, db_port, db_user, db_password, db_name)
board_data_repository = BoardDataRepository.new(trello_dev_key, trello_token)
metrics_calculator = MetricsCalculator.new
metrics_repository = MetricsRepository.new(orchestrate_api_key, orchestrate_collection, orchestrate_endpoint)

boardIdToLoad = board_repository.find_board_to_load
board_repository.start_updating(boardIdToLoad)
board_data = board_data_repository.get_board_data(boardIdToLoad)
metrics_data = metrics_calculator.calculate_cycletime(board_data)
metrics_repository.store_metrics(metrics_data)
board_repository.complete_updating(boardIdToLoad)
