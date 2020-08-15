class RecipesController < ApplicationController
  before '/recipes/*' do
    redirect to '/login' unless logged_in?
  end

  get '/recipes' do
    @recipes = Recipe.where("private = ? OR user_id = ? AND private = ?", false, current_user.id, true)
    erb :'recipes/recipes'
  end

  get '/recipes/new' do
    erb :'recipes/create_recipe'
  end

  post '/recipes' do
    redirect to '/recipes/new' if params[:instructions] == '' || params[:name] == ''
    @recipe = current_user.recipes.build(instructions: params[:instructions], name: params[:name], private: (params[:private] == 'on'), user_id: current_user.id)
    if @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    else
      redirect to 'recipes/new'
    end
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :'recipes/show_recipe'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    if @recipe && @recipe.user == current_user
      erb :'recipes/edit_recipe'
    else
      redirect to '/recipes'
    end
  end

  patch '/recipes/:id' do
    if params[:instructions] == '' || params[:name] == ''
      redirect to "/recipes/#{params[:id]}/edit"
    else
      @recipe = Recipe.find(params[:id])
      if @recipe && @recipe.user == current_user
        if @recipe.update(instructions: params[:instructions], name: params[:name], private: (params[:private] == 'on'))
          redirect to "recipes/#{@recipe.id}"
        else
          redirect to "/recipes/#{recipe.id}/edit"
        end
      else
        redirect to '/recipes'
      end
    end
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect to '/recipes'
  end
end
