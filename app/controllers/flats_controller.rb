class FlatsController < ApplicationController
  helper_method :build_flat_path
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @is_my_flats = params[:myflats] == '1'
    if !@is_my_flats
      @flats = policy_scope(Flat)
    else
      user_id = current_user.id
      @flats = policy_scope(Flat).where("user_id = #{user_id}")
    end
  end

  def build_flat_path(flat)
    @is_my_flats ? edit_flat_path(flat) : flat_path(flat)
  end

  def show
    @flat = Flat.find(params[:id])
    @user = current_user
    @booking = Booking.new
    authorize @flat
  end

  def edit
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def update
    @flat = Flat.find(params[:id])
    authorize @flat
    if @flat.update(flat_params)
      flash[:success] = "Se actualizó correctamente"
      redirect_to flats_path(myflats: '1')
    else
      flash[:alert] = "Ingrese datos correctos"
      redirect_to edit_flat_path(@flat)
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
      redirect_to flats_path(myflats: '1')
    else
      render :new
    end
  end

  def destroy
    @flat = Flat.find(params[:id])
    authorize @flat
    @flat.destroy
    redirect_to flats_path(myflats: '1')
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :address, :number_of_pets, :price_per_night, :description, photos: [])
  end
end
