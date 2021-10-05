class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @user = User.find(params[:user_id])
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
    @user = User.find(params[:user_id])
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
    @user = User.find(params[:user_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.status = "pending"
    if @booking.save
      redirect_to user_booking_path(@booking, @user)
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
    params.require(:booking).permit(:start_date, :end_date, :user_id, :flat_id)
  end
end
