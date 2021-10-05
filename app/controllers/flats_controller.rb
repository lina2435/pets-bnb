class FlatsController < ApplicationController
  def index
    @flats = Flat.all
  end

  def show
  end

  def new
    @flat = Flat.new
    puts Flat.all.size
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to flats_path
    else
      render :new
    end
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    redirect_to flats_path
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :address, :number_of_pets, :price_per_night, :description)
  end
end
