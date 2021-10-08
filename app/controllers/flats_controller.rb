class FlatsController < ApplicationController
  helper_method :build_flat_path
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @is_my_flats = params[:myflats] == '1'
    if !@is_my_flats
      @flats = policy_scope(Flat).geocoded
    else
      user_id = current_user.id
      @flats = policy_scope(Flat).where("user_id = #{user_id}").geocoded
    end
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end

    if params[:priceRange].present?
      @query_price = params[:priceRange]
      if @query_price  == "1"
        puts "aqui"
        @flats = @flats.where("price_per_night < 100")
      elsif @query_price == "2"
        puts "aki2"
        @flats.where('price_per_night BETWEEN 100 AND 200')
      elsif @query_price == "3"
        puts "aki3"
        @flats.where("price_per_night > 200")
      end
    end

    if params[:petRange].present?
      @query_pet_range = params[:petRange]
      if @query_pet_range  == "1"
        @flats.where("number_of_pets == 1")
      elsif @query_pet_range == "2"
        @flats.where('number_of_pets == 2')
      elsif @query_pet_range == "3"
        @flats.where("number_of_pets == 3")
      elsif @query_pet_range == "4"
        @flats.where("number_of_pets>= 4")
      end
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
