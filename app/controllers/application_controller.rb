require_relative '../../config/environment'
require 'sinatra/base'

class ApplicationController < Sinatra::Base
	enable :session 

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/recipes' do
    @recipes = Recipe.all
    # binding.pry
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save
    @recipe = recipe
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
 
    erb :show
  end

  delete '/recipes/:id/delete' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect "/recipes"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
  	binding.pry
    recipe = Recipe.find_by_id(params[:id])
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save
    @recipe = recipe
    erb :show
  end

end
