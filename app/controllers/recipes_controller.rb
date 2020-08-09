class RecipesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
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
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def show; end

  def edit
    unless same_user(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end

    @recipe.instructions.first_or_create
    5.times { @recipe.ingredients.build }
  end

  def update
    unless same_user(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])

    if same_user?(recipe.user)
      recipe.destroy
      redirect_to root_path
    else
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name,
                                   :image,
                                   instructions_attributes: %i[name id],
                                   ingredients_attributes: %i[name _destroy id])
  end
end
