class UsersController < ApplicationController
  before_action :set_user, only: :show
  def upgrade_to_host
    @user = User.find(current_user.id)
    @user.host = true
    @user.save
    authorize @user
    flash[:success] = "Felicidades ahora eres host"
    redirect_to flats_path
  end
end
