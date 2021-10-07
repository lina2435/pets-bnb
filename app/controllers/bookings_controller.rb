class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def bookings_as_owner
    skip_authorization
    @bookings = current_user.bookings_as_owner
    render :bookings_as_owner
  end

  def show
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def edit
    skip_authorization
    @booking = Booking.find(params[:id])
    @flat = Flat.find(params[:flat_id])
  end

  def update
    skip_authorization
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.find(params[:id])
    @booking.status = "accepted"
    if @booking.update(booking_params)
      redirect_to bookings_as_owner_path
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
    @booking.number_of_days = @booking.end_date - @booking.start_date
    @booking.total_price = @flat.price_per_night * @booking.number_of_days
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
    redirect_to bookings_as_owner_path
    authorize @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
