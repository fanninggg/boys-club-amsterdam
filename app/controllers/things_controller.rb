class ThingsController < ApplicationController

  def index
    @things = Thing.where.not(latitude: nil, longitude: nil)
    @coffeeshops = @things.where(category: "Coffeeshop")
    @foods = @things.where(category: "Food")
    @bars = @things.where(category: "Bar")
    @others = @things.where(category: "Other")

    @markers = @things.map do |thing|
      {
        lat: thing.latitude,
        lng: thing.longitude,
        infoWindow: render_to_string(partial: "things/pop_up", locals: { thing: thing }),
        image_url: helpers.asset_url(marker_image(thing.category))
      }
    end
  end

  def marker_image(category)
    case category
      when "Coffeeshop"
        "https://upload.wikimedia.org/wikipedia/commons/a/a8/Cannabis_leaf.svg"
      when "Food"
        "https://www.svgrepo.com/show/169724/burger.svg"
      when "Bar"
        "http://clipart-library.com/newimages/beer-mug-clip-art-9.png"
      else
        "https://image.flaticon.com/icons/svg/33/33622.svg"
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
      redirect_to things_path
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
