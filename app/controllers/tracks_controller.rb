class TracksController < ApplicationController
  before_action :find_track, only: [:edit, :show, :destroy, :update]
  before_action :require_current_user!

  def new
    @album = Album.find(params[:album_id])
    @albums = @album.band.albums
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to @track
    else
      flash.now[:errors] = @track.errors.full_messages
      @album = @track.album
      @albums = @album.band.albums
      render :new
    end
  end

  def destroy
    album = @track.album
    if @track.destroy
      redirect_to album
    else
      flash.now[:errors] = ["Track is invincible"]
      render @track
    end
  end

  def edit
    @album = @track.album
    @albums = @track.band.albums
  end

  def update
    if @track.update(track_params)
      redirect_to @track
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
  end

  def index
    @tracks = Track.all
  end

  private

  def track_params
    params.require(:track).permit(:title, :track_type, :album_id, :lyrics)
  end

  def find_track
    @track = Track.find(params[:id])
  end

end
