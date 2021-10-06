class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def edit
    @booking = Booking.find(params[:id])
    @flat = Flat.find(params[:flat_id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to flats_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    @booking.status = "pending"
    authorize @booking
    if @booking.save
      redirect_to flat_booking_path(@flat, @booking)
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to flats_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
