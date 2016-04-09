class MetricsCalculator
  def calculate_cycletime(board_data)
    cycletime_data = board_data.collect do |card|
      name = card.name
      id = card.id
      board_id = card.board_id

      starting_actions = card.actions.select{|a| a.data["listAfter"] && a.data["listAfter"]["name"] == "Working"}
      starting_timestamp = starting_actions.sort{ |l, r| l.date <=> r.date }.last.date

      ending_actions = card.actions.select{|a| a.data["listAfter"] && a.data["listAfter"]["name"] == "Complete"}
      ending_timestamp = ending_actions.sort{ |l, r| l.date <=> r.date }.last.date

      estimate = 9999
      card.card_labels.each do |label|
        regex = /^([0-9])/
        result = regex.match(label["name"])
        estimate = result[1] unless result == nil
      end

      cycle_time = week_days_between(starting_timestamp, ending_timestamp)

      cycletime_metric = {
          id: id,
          name: name,
          board_id: board_id,
          estimate: estimate,
          cycle_time: cycle_time,
          start_time: starting_timestamp,
          end_time: ending_timestamp
      }

      puts "#{cycletime_metric}"
      STDOUT.flush

      cycletime_metric
    end

    cycletime_data
  end

  def week_days_between start_date, end_date
    sd = start_date.to_datetime
    ed = end_date.to_datetime
    r = Range.new(sd, ed)
    r.select{|day| (day.saturday? || day.sunday?) == false}.size
  end
end
