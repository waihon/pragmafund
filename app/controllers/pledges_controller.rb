class PledgesController < ApplicationController
  before_action :set_project

  def index
    @pledges = @project.pledges
  end

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(pledge_params)
    if @pledge.save
      redirect_to project_pledges_path(@project), notice: "Thanks for pledging!"
    else
      render :new
    end
  end

  def edit
    @pledge = Pledge.find(params[:id])
  end

  def update
    @pledge = Pledge.find(params[:id])
    if @pledge.update(pledge_params)
      redirect_to project.project_pledges_path(@project, @pledge),
                  notice: "Pledge successfully updated!"
    else
      redirect_to :edit
    end
  end

  def destroy
    @pledge = Pledge.find(params[:id])
    @pledge.destroy
    redirect_to project_pledges_path(@project), alert: "Pledge successfully deleted!"
  end

  private
    def pledge_params
      params.require(:pledge).permit(:name, :email, :comment, :amount)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
