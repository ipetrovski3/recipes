class RecipesController < ApplicationController
  before_action :set_recipe, except: %i[index new create]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.instructions.build
    10.times { @recipe.ingredients.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = User.first

    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def show; end

  def edit
    @recipe.instructions.first_or_create
    5.times { @recipe.ingredients.build }
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    recipe.destroy

    redirect_to root_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name,
                                   :head_image,
                                   instructions_attributes: %i[name id],
                                   ingredients_attributes: %i[name _destroy id])
  end
end
