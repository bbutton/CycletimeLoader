require 'orchestrate'

class MetricsRepository
  def initialize(orchestrate_api_key, orchestrate_collection, orchestrate_endpoint)
    @orchestrate_api_key = orchestrate_api_key
    @orchestrate_collection = orchestrate_collection
    @orchestrate_endpoint = orchestrate_endpoint
  end

  def store_metrics(metrics_data)
    app = Orchestrate::Application.new(@orchestrate_api_key, @orchestrate_endpoint)
    trello_data = app[@orchestrate_collection]

    metrics_data.each do |data|
        trello_data << data
    end
  end
end