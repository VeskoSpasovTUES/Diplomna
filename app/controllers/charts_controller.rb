class ChartsController < ApplicationController
  def index
    @teams = Team.limit(2) # Initial teams for selection

    if params[:team_ids]
      @selected_teams = Team.find(params[:team_ids])
      @chart_data = prepare_chart_data(@selected_teams)
    end
  end

  skip_before_action :verify_authenticity_token, only: [:fetch_chart_data]

  def process_teams
    team_ids = params[:team_ids]
    unique_team_ids = team_ids.uniq

    if unique_team_ids.size == team_ids.size # Validation check
      @teams = Team.find(unique_team_ids)
      render :index # Render chart view with selected teams
    else
      @error_message = "Please select unique teams"
      @available_teams = Team.all
      render :index # Re-render form with error
    end
  end

  def fetch_chart_data
    team_ids = params[:team_ids]
    race_id = params[:race_id]

    team_ids_array = team_ids.map(&:to_i)  # Convert to array of integers
    teams = Team.includes(:laps).where(id: team_ids_array)

    chart_data = prepare_chart_data(teams, race_id)

    render json: chart_data
  end

  private

  def prepare_chart_data(teams, race_id)
    teams.map do |team|
      team_laps = team.laps.where(race_id: race_id)
      #puts "Team laps (filtered): #{team_laps}"

      lap_data = team_laps.map { |lap| [lap.number, lap.time] }

      { name: team.name, data: lap_data }
    end
  end
end
