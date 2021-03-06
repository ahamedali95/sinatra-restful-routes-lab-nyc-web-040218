class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #index action
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  #new action
  get "/recipes/new" do
    erb :new
  end

  post "/recipes" do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  #show action
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id].to_i)
    erb :show
  end

  #update action
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id].to_i)
    erb :edit
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id].to_i)
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  #delete action
  delete "/recipes/:id/delete" do
    @recipe = Recipe.find(params[:id].to_i)
    @recipe.delete
    redirect to "/recipes"
  end

end
