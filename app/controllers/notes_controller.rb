class NotesController < ApplicationController
  before_action :find_track, except: [:destroy]

  def new
    @note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = @track.id

    if @note.save
      redirect_to @track
    else
      flash.now[:errors] = @note.errors.full_messages
      redirect_to @track
    end
  end

  def destroy
    @note = Note.find(params[:id])
    track = @note.track

    if current_user.id == @note.user_id
      @note.destroy
      redirect_to track
    else
      render text: "You can not delete other users' notes!", status: :forbidden
    end
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def find_track
    @track = Track.find(params[:track_id])
  end
end
