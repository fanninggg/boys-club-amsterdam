class ThingsController < ApplicationController

  def index
    @things = Thing.where.not(latitude: nil, longitude: nil)

    @markers = @things.map do |thing|
      {
        lat: thing.latitude,
        lng: thing.longitude,
        infoWindow: render_to_string(partial: "things/pop_up", locals: { thing: thing })
      }
    end
  end

  def show
    @thing = Thing.find(params[:id])
  end

  def new
    @thing = Thing.new
  end

  def create
    @thing = Thing.create(thing_params)
    if @thing.save
      redirect_to thing_path(@thing)
    else
      render :new
    end
  end

  def edit
    @thing = Thing.find(params[:id])
  end

  def update
    @thing = Thing.find(params[:id])
    @thing.update(thing_params)
    redirect_to thing_path(@thing)
  end

  def destroy
    @thing = Thing.find(params[:id])
    @thing.destroy
    redirect_to things_path
  end

  private

  def thing_params
    params.require(:thing).permit(:name, :category, :website, :notes, :address, :latitude, :longitude)
  end

end
