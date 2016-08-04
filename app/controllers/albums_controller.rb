class AlbumsController < ApplicationController
  before_action :find_album, only: [:edit, :show, :destroy, :update]
  before_action :find_bands, only: [:new, :edit]
  before_action :require_current_user!

  def new
    @band = Band.find(params[:band_id])
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album
    else
      flash.now[:errors] = @album.errors.full_messages
      @bands = Band.all
      @band = @album.band
      render :new
    end
  end

  def destroy
    band = @album.band
    if @album.destroy
      redirect_to band
    else
      flash.now[:errors] = ["Album is invincible"]
      render @album
    end
  end

  def edit
    @band = @album.band
  end

  def update
    if @album.update(album_params)
      redirect_to @album
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def show
  end

  def index
    @albums = Album.all
  end

  private

  def album_params
    params.require(:album).permit(:title, :album_type, :band_id)
  end

  def find_album
    @album = Album.find(params[:id])
  end

  def find_bands
    @bands = Band.all
  end
end
