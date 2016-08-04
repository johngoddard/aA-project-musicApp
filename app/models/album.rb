class Album < ActiveRecord::Base
  validates :band_id, :title, :album_type, presence: true
  validates :album_type, inclusion: %w(studio live)

  belongs_to :band
  has_many :tracks, dependent: :destroy

end
