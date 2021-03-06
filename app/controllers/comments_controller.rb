class CommentsController < ApplicationController

	def new
      @listing = Listing.find(params[:listing_id])
  		@comment = Comment.new(parent_id: params[:parent_id])
	end

	def create
    @listing = Listing.find(params[:listing_id])

    p params
    p params[:comment][:parent_id]

    if params[:comment][:parent_id].to_i > 0
      parent_id = params[:comment][:parent_id]
      @listing.comments.create(comment_params)
      Comment.last.update_columns(user_id: current_user.id)
      success
    else
  		@listing.comments.create(comment_params)
  		Comment.last.update_columns(user_id: current_user.id)
      success
    end
  end


	def comment_params
  	params.require(:comment).permit(:thoughts, :parent_id)
	end

  def success
    flash[:success] = 'Your comment was successfully added!'
    redirect_to listing_path(@listing.id)
  end

end
