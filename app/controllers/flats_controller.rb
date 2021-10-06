class FlatsController < ApplicationController
  def index
    # @flats = Flat.order("id ASC").all
    @flats = policy_scope(Flat)
  end

  def show
    @flat = Flat.find(params[:id])
    @booking = Booking.new
    authorize @flat
  end

  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:id])
    if @flat.update(flat_params)
      redirect_to flats_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @user = current_user
    @flat = Flat.new(flat_params)
    @flat.user = @user
    authorize @flat
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
