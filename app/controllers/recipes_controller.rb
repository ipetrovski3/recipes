class RecipesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_recipe, except: %i[index new create]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    10.times { @recipe.instructions.build }
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
    unless same_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end

    5.times { @recipe.instructions.build }
    5.times { @recipe.ingredients.build }
  end

  def update
    unless same_user?(@recipe.user)
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

  def edit_ingredients
    unless same_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end

    5.times { @recipe.ingredients.build }
  end

  def update_ingredients
    unless same_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end
    if @recipe.ingredients.update(ingredient_params)
      redirect_to @recipe
    else
      render :edit_ingredients
    end
  end

  def edit_instructions
    unless same_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end

    5.times { @recipe.instructions.build }
  end

  def update_instructions
    unless same_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path) and return
    end
    if @recipe.instructions.update(instruction_params)
      redirect_to @recipe
    else
      render :edit_instructions
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name,
                                   :image,
                                   :description,
                                   instructions_attributes: %i[name id _destroy],
                                   ingredients_attributes: %i[name id _destroy])
  end

  def ingredient_params
    params.permit(:name)
  end

  def instruction_params
    params.permit(:name)
  end
end
