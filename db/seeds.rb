# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Band.create!(name: "Pavement")
Band.create!(name: "Modest Mouse")

Album.create!(band_id: 1, title: "Slanted and Enchanted", album_type: "studio")
Album.create!(band_id: 2, title: "Good News for People who Love Bad News", album_type: "studio")

Track.create(album_id: 1, title: "In the Mouth a Desert", lyrics: "Can you treat it like an oil well", track_type: "regular")
Track.create(album_id: 1, title: "Here", lyrics: "I was dressed for success, but sucess it never comes...", track_type: "regular")
Track.create(album_id: 2, title: "Float On", lyrics: "I backed my car into a cop car the other day...", track_type: "regular")
Track.create(album_id: 2, title: "The Good Times are Killing Me", lyrics: "The Good times are killing me...", track_type: "regular")
