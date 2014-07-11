class TeamsController < ApplicationController

  def index
  end

  def show
    team = Team.find(params[:id])
    games = team.games.select{|game| game.total_calls > 0}

    render json: {team: team, games: games}
  end




end