class InstructionsController < ApplicationController
  def new
    @recipe = Recipe.find_by(params[:recipe_id])
  end

  def create
    @recipe = Recipe.find_by(params[:recipe_id])
    @instruction = @recipe.instructions.build
  end
end
