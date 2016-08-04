class BandsController < ApplicationController
  before_action :find_band, only: [:edit, :show, :destroy, :update]
  before_action :require_current_user!

  def new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to @band
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def destroy
    if @band.destroy
      redirect_to bands_url
    else
      flash.now[:errors] = ["Band is invincible"]
      render @band
    end
  end

  def edit
  end

  def update
    if @band.update(band_params)
      redirect_to @band
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def show
  end

  def index
    @bands = Band.all
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def find_band
    @band = Band.find(params[:id])
  end
end
