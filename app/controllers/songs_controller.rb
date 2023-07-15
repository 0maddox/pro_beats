class SongsController < ApplicationController
    def index
        songs = song.all 
        if session[:user_id].present?
            render json: songs ,status: :ok
        else
            render json: { errors: "Unauthorized"}, status: :unauthorized
        end
    end
    def show
        song = Song.find_by(id:params[:id])
        if song
          render json: song
        else
          render json: { error: "Not Found" }, status: :not_found
        end
    end

    def create
        if session[:user_id].present?
          song = Song.create(song_params)
           
      
          if song
            render json: song,  status: :created
          else
            render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Unauthorized"}, status: :unauthorized
        end
      end

      def song_params
        params.permit(:name, :description, :category, :album, :genre)
      end
end
