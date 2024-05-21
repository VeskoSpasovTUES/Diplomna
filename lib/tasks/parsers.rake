require 'csv'
namespace :parsers do
  desc "Parse the laptimes from a csv file"
  task :laptimes, [:arg1] => [:environment] do |t, args|
    csv_file_path = args[:arg1]
    current_team = nil
    current_lap_number = 0
    race_name = nil
    got_race_name = false
    race = nil
  
    CSV.foreach(csv_file_path) do |row|
      values = row.to_a

      if !got_race_name && values.any?
        race_name = values.first.strip
        got_race_name = true
        p race_name

      elsif values.first =~ /\d{2}\/\d{2}\/\d{4} - \d{2}:\d{2}/
        date = Date.parse(values.first.split('-').first.strip)

        race = Race.find_or_create_by(name: race_name, date: date)

      elsif values.first =~ /\d+\s*-\s*\w/
        current_lap_number = 0
        team_name = values.first.split('-').last.strip
        p team_name

        current_team = Team.find_or_create_by(name: team_name)

      elsif values.first && values.first.casecmp?("Laps")

      elsif values.any?
          lap_times_data = values[1..-1]
          process_lap_times(current_team, lap_times_data, race, current_lap_number)
          current_lap_number += 10
      end
    end

    puts "Lap times imported successfully!"
  end

  def process_lap_times(team, lap_times_data, race, lap_number)
    return if team.nil?

    lap_times_data.each_with_index do |lap_time_str|
      lap_number += 1
      next unless lap_time_str.present?

      begin
        lap_time = lap_time_str.to_f
      rescue ArgumentError
        puts "Warning: Invalid lap time value for team #{team.name}, lap #{lap_number}: #{lap_time_str}"
        next
      end

      Lap.create!(
        number: lap_number,
        time: lap_time,
        race: race,
        team: team
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

    end

    puts "Lap time data imported successfully!"
  end

end
