require 'mysql2'

class BoardRepository
  def initialize(db_url, db_port, db_user, db_password, db_name)
    @client = Mysql2::Client.new(:host => db_url, :port => db_port, :username => db_user, :password => db_password, :database => db_name)
  end

  def start_updating(board_id_to_load)

  end

  def find_board_to_load
    results = @client.query("select board_id from boards")
    results.each { |r| puts "Result: #{r}" }
    results.first()["board_id"]
  end

  def complete_updating(board_id_to_load)

  end
end