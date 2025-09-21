class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy]

  def index
    @spots = Spot.all.order(:name)
  end

  def show
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    
    if @spot.save
      redirect_to @spot, notice: 'Spot was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @spot.update(spot_params)
      redirect_to @spot, notice: 'Spot was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    redirect_to spots_url, notice: 'Spot was successfully deleted.'
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :description)
  end
end
