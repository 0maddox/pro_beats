class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user_id, :song_id
  belongs_to :song
end
