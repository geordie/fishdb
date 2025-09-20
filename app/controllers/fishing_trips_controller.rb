class FishingTripsController < ApplicationController
  before_action :set_fishing_trip, only: [:show, :edit, :update, :destroy]

  def index
    @fishing_trips = FishingTrip.recent
  end

  def show
  end

  def new
    @fishing_trip = FishingTrip.new
  end

  def create
    @fishing_trip = FishingTrip.new(fishing_trip_params)
    
    if @fishing_trip.save
      redirect_to @fishing_trip, notice: 'Fishing trip was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @fishing_trip.update(fishing_trip_params)
      redirect_to @fishing_trip, notice: 'Fishing trip was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fishing_trip.destroy
    redirect_to fishing_trips_url, notice: 'Fishing trip was successfully deleted.'
  end

  private

  def set_fishing_trip
    @fishing_trip = FishingTrip.find(params[:id])
  end

  def fishing_trip_params
    params.require(:fishing_trip).permit(:date, :fish, :notes)
  end
end
