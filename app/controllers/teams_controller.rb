class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @teams = Team.all
    @sports = Sport.where(is_active: 'true')
    if @sports.blank?
      redirect_to sports_path, notice: "ベンチャースポーツを追加してください。"
    # elsif params[:sport_id].blank?
    #   @q = Team.ransack(params[:q])
    #   @teams = @q.result(distinct: true).order(name: :DESC)
    else
      @q = Team.ransack(params[:q])
      # @sport = Sport.find(params[:sport_id])
      # @teams = @sport.teams.all.order(name: :DESC)
      @teams = @q.result.order(name: :DESC)
    end
  end

  def new
    @sports = Sport.where(is_active: 'true')
    if @sports.blank?
      redirect_to sports_path, notice: "ベンチャースポーツを追加してください。"
    else
    @team = Team.new
    end
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id
    if @team.save
      # @tags = Vision.get_image_data(@team.image)
      # @tags.each do |tag|
      #   @team.tags.create(name: tag)
      # end
      redirect_to teams_path, notice: "チームを設立しました。"
    else
      @sports = Sport.where(is_active: 'true')
      render :new
    end
  end

  def show
    @sports = Sport.where(is_active: true)
    @team = Team.find(params[:id])
    @comment = Comment.new
    @comments = @team.comments
  end

  def edit
    @team = Team.find(params[:id])
    @sports = Sport.where(is_active: 'true')
    if @team.user_id = current_user.id
      render :edit
    else
      redirect_to teams_path
    end
  end

  def update
    @team = Team.find(params[:id])
    @team.user_id = current_user.id
    if @team.update(team_params)
      redirect_to team_path(@team.id), notice: "チーム情報を更新しました。"
    else
      @sports = Sport.where(is_active: 'true')
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:notice] = "チームを削除しました。"
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :introduction, :number, :status, :address, :image, :user_id, :sport_id, :longitude, :latitude, :prefecture_code)
  end
end
