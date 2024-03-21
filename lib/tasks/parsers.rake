require 'csv'
namespace :parsers do
  desc "Parse the laptimes from a csv file"
  task :laptimes, [arg1] => [:environment] do |t, args|
    csv_file_path = args[:arg1]
    $current_team = nil
    $current_lap_number = 0
    race_name = nil
    got_race_name = false
    $race = nil

    CSV.foreach(csv_file_path) do |row|
      values = row.to_a

      #next if values.empty?
      if !got_race_name && values.any?
        race_name = values.first.strip
        got_race_name = true
        p race_name

      elsif values.first =~ /\d{2}\/\d{2}\/\d{4} - \d{2}:\d{2}/  # Regex for date
        date = Date.parse(values.first.split('-').first.strip)

        $race = Race.find_or_create_by(name: race_name, date: date)

        $current_team = nil
        next

      # Detect and handle the team row
      elsif values.first =~ /\d+\s*-\s*\w/
        $current_lap_number = 0
        team_name = values.first.split('-').last.strip
        p team_name

        $current_team = Team.find_or_create_by(name: team_name)

      # Skip rows starting with "Laps"
      elsif values.first && values.first.casecmp?("Laps")
        next

      # Process rows with lap times, skipping the first column
      elsif values.any?
          lap_times_data = values[1..-1]
          process_lap_times($current_team, lap_times_data)
      end
    end

    puts "Lap times imported successfully!"
  end

  def process_lap_times(team, lap_times_data)
    return if $current_team.nil?

    lap_times_data.each_with_index do |lap_time_str|
      $current_lap_number += 1
      lap_number = $current_lap_number
      #p lap_number
      next unless lap_time_str.present?  # Skip empty values

      begin
        lap_time = lap_time_str.to_f  # Attempt to convert to float
        #p lap_time
      rescue ArgumentError
        puts "Warning: Invalid lap time value for team #{team.name}, lap #{lap_number}: #{lap_time_str}"
        next
      end

      # Create the LapTime record
      lap = Lap.create!(
        number: lap_number,
        time: lap_time,
        race: $race,
        team: $current_team
      )
    end
  end

  desc "Parse the pitstops from a csv file"
  task pitstops: :environment do
    csv_file_path = '/home/vesko/Diplomna/Results-4/Results-4/4H/pitstops.csv'

    CSV.foreach(csv_file_path, headers: true, col_sep: ';', encoding: 'UTF-8') do |row|
      team_name = row[0]
      lap_number = row[1].to_i
      total_time = row['total_time'].to_f
      driver_name = row['driver_name']
      race_name = row['race']
      date_string = row['date']

      p race_name
      p lap_number
      #p date_string

      if date_string.present?
        date = Date.parse(date_string)
        p date
      else
        date = nil
      end

      #p row.to_hash

      # Find or create the Team based on its name
      # team = Team.find_or_create_by(name: team_name)
    end

    puts "Lap time data imported successfully!"
  end

end
