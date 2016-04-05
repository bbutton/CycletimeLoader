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

board_id_to_load = nil
loop do
  begin
    puts "Beginning polling cycle in 10 seconds"
    sleep(10)

    puts("Checking for any boards to load")
    board_id_to_load = board_repository.find_board_to_load
    next if board_id_to_load == nil

    puts("Retrieving board data for #{board_id_to_load}")
    board_data = board_data_repository.get_board_data(board_id_to_load)

    puts("Calculating Cycletime metrics")
    metrics_data = metrics_calculator.calculate_cycletime(board_data)

    puts("Storing metrics")
    metrics_repository.store_metrics(metrics_data)

    puts("Finalizing update and restarting process")
    board_repository.complete_updating(board_id_to_load)
  rescue => e
    if(board_id_to_load == nil)
      puts("Error while processing. Unable to read board_id: #{e}. Restarting process")
    else
      puts("Error while processing #{board_id_to_load}: #{e}. Setting interrupt bit and restarting process")
      board_repository.set_interrupted(board_id_to_load)
    end
  end
end

