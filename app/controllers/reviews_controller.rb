class ReviewsController < ApplicationController
    def index
        reviews = Review.all 
        if session[:user_id].present?
            render json: reviews,status: :ok
        else
            render json: { errors: "Unauthorized"}, status: :unauthorized
        end
    end

    def event_reviews
      reviews = Review.where(event_id:params[:event_id])

      render json: reviews,status: :ok
    end

    def create
        if session[:user_id].present?
          review = Review.create(review_params)
           review.user_id = session[:user_id]
      
          if review
            render json: review, include: :event, status: :created
          else
            render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Unauthorized"}, status: :unauthorized
        end
      end

    def destroy
     review =find_review
  
      if session[:user_id].present? && review.user_id == session[:user_id]
        review.destroy
        render json: { message: "Review deleted successfully" }, status: :ok
      else
       render json: { errors: "Unauthorized" }, status: :unauthorized
      end
    end

       
      private

      def review_params
      params.permit(:comment, :user_id, :event_id)
      end

      def find_review
        Review.find(params[:id])
      end

end
