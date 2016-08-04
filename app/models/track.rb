class Track < ActiveRecord::Base
  validates :album_id, :title, :track_type, presence: true
  validates :track_type, inclusion: %w(regular bonus)

  belongs_to :album
  has_many :notes

  has_one :band,
    through: :album,
    source: :band
end
