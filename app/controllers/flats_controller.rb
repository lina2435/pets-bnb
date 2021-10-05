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
    puts "errors: #{@flat.errors.count}"
    @flat.user
    if @flat.save
      puts "aqui"
      redirect_to flats_path
    else
      puts "aya"
      render :new
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :address, :number_of_pets, :price_per_night, :description)
  end
end
