class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :album, :artist, :genre
end
