class Api::V1::RecipesController < ApplicationController

  def index
    country = params[:country]
    @recipes = RecipesFacade.new.search_by_country(country)
    render json: RecipesSerializer.new(@recipes).serializable_hash.to_json
  end
end