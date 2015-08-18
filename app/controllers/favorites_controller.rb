class FavoritesController < ApplicationController

  def create
    recipe = Recipe.find_by_id(favorite_params[:recipe_id])
    if current_user.favorite_recipes.include? recipe
      render json: {}, status: :bad_request
    else
      @favorite = current_user.favorites.new(favorite_params)
      if @favorite.save
        render json: @favorite
      else
        render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private
    def favorite_params
      params.require(:favorite).permit(:recipe_id)
    end

end