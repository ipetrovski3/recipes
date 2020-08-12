require 'rails_helper'

RSpec.describe 'Recipes' do
  describe 'Creating an recipe' do
    context 'when no user is logged in' do
      it 'redirects back to login path' do
        post_params = {
          params: {
            recipe: {
              name: 'New recipe'
            }
          }
        }
        post '/recipes', post_params
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq 'Please sign in to continue'
      end
    end
  end

  describe 'Editing an recipe' do
    context "when the recipe's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      it 'can edit the recipe' do
        get '/login'
        expect(response).to have_http_status(:ok)
        post_params = {
          params: {
            session: {
              mail: user.mail,
              password: user.password
            }
          }
        }
        post '/login', post_params
        follow_redirect!
        expect(flash[:success]).to eq "Welcome #{user.name} !!!"
        get "/recipes/#{recipe.id}"
        expect(response).to have_http_status(:ok)
        get "/recipes/#{recipe.id}/edit"
        expect(response).to have_http_status(:ok)
        patch_params = {
          params: {
            recipe: {
              name: recipe.name,
              instrucions: 'New',
              ingredients: 'new ing'
            }
          }
        }
        patch "/recipes/#{recipe.id}", patch_params
        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include(recipe.name)
      end
    end
  end
end
