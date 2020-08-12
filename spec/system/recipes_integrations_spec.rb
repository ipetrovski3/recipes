require 'rails_helper'

RSpec.describe 'RecipesIntegrations', type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    driven_by(:rack_test)

    visit login_path

    within('form') do
      fill_in 'Email', with: user.mail
      fill_in 'Password', with: user.password
      click_on 'Sign In'
    end
  end

  describe 'Creating a Recipe' do
    it 'creates and shows the newly created Recipe' do
      name = 'Create new system spec'
      instructions = 'This is the instruction'
      ingredients = 'This is the ingredient'
      within('nav') do
        click_on('New Recipe')
      end

      within('form') do
        fill_in 'recipe_name', with: name
        fill_in 'recipe_instructions_attributes_0_name', with: instructions
        fill_in 'recipe_ingredients_attributes_0_name', with: ingredients
        click_on 'Create'
      end
      expect(page).to have_content(name)
      expect(page).to have_content(ingredients)
      expect(page).to have_content(instructions)
    end
  end

  describe 'Editing an recipe' do
    it 'edits and shows the recipe' do
      name = 'Edit system spec'
      instructions = 'This is the edited instruction'
      ingredients = 'This is the edited ingredient'
      visit recipe_path(recipe)
      click_on 'Edit Recipe'
      within('form') do
        fill_in 'recipe_name', with: name
        fill_in 'recipe_instructions_attributes_0_name', with: instructions
        fill_in 'recipe_ingredients_attributes_0_name', with: ingredients
        click_on 'Edit Recipe'
      end
      expect(page).to have_content(name)
      expect(page).to have_content(ingredients)
      expect(page).to have_content(instructions)
    end
  end

  describe 'Deleting an recipe' do
    it 'deletes the recipe and redirect to index view' do
      visit recipe_path(recipe)
      click_on 'Delete Recipe'
      expect(page).to have_content('Recipes')
    end
  end
end
