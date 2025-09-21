class FishingTripsController < ApplicationController
  before_action :set_fishing_trip, only: [:show, :edit, :update, :destroy]

  def index
    @fishing_trips = FishingTrip.includes(:spot).recent
  end

  def show
  end

  def new
    @fishing_trip = FishingTrip.new
    @spots = Spot.by_name
  end

  def create
    @fishing_trip = FishingTrip.new(fishing_trip_params)
    
    if @fishing_trip.save
      redirect_to @fishing_trip, notice: 'Fishing trip was successfully created.'
    else
      @spots = Spot.by_name
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @spots = Spot.by_name
  end

  def update
    if @fishing_trip.update(fishing_trip_params)
      redirect_to @fishing_trip, notice: 'Fishing trip was successfully updated.'
    else
      @spots = Spot.by_name
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fishing_trip.destroy
    redirect_to fishing_trips_url, notice: 'Fishing trip was successfully deleted.'
  end

  private

  def set_fishing_trip
    @fishing_trip = FishingTrip.includes(:spot).find(params[:id])
  end

  def fishing_trip_params
    params.require(:fishing_trip).permit(:date, :fish, :notes, :spot_id).tap do |whitelisted|
      whitelisted[:spot_id] = nil if whitelisted[:spot_id].blank?
    end
  end
end
