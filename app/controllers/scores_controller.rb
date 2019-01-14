class ScoresController < ApplicationController
  CREATE_URL = "http://localhost:3000/api/scores"
  UPDATE_URL = "http://localhost:3000/api/scores/update_score"
  def index
    @scores = Score.all
  end

  def new
    @score = Score.new
  end

  def create
    @score = Score.new(score_params)
    if @score.save
      HTTParty.post(CREATE_URL, body: { score: JSON.parse(@score.to_json) })
      redirect_to scores_path
    else
      render "new"
    end
  end

  def edit
    @score = Score.find_by(id: params[:id])
  end

  def update
    @score = Score.find_by(id: params[:id])
    if @score.update_attributes(score_params)
      HTTParty.post(UPDATE_URL,
                    body: { score: JSON.parse(@score.to_json) })
      redirect_to scores_path
    else
      render "edit"
    end
  end

  private

  def score_params
    params.require(:score).permit(:home_team, :home_score, :away_team, :away_score)
  end
end
