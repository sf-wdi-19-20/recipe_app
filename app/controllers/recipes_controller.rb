class RecipesController < ApplicationController
  before_filter :authorize, except: [:index, :show]

  # show ALL recipes in db
  def index
    @recipes = Recipe.all
    render :index
  end

  # form to create new recipe
  def new
    @recipe = Recipe.new
    render :new
  end

  # creates new recipe in db
  # that BELONGS TO current_user
  def create
    # recipe = Recipe.create(recipe_params)
    # current_user.recipes << recipe
    # recipe = current_user.recipes.create(recipe_params)
    # redirect_to recipe_path(recipe)
    
    recipe = current_user.recipes.new(recipe_params)
    if recipe.save
      flash[:notice] = "Successfully created recipe."
      redirect_to recipe_path(recipe)
    else
      flash[:error] = recipe.errors.full_messages.join(", ")
      redirect_to new_recipe_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end

  # form to edit one recipe
  def edit
    @recipe = Recipe.find(params[:id])
    if current_user.recipes.include? @recipe
      render :edit
    else
      # if user tries to edit recipe that doesn't belong to them
      # log them out
      session[:user_id] = nil
      redirect_to login_path
    end
  end

  # updates recipe in db
  def update
    recipe = Recipe.find(params[:id])
    if current_user.recipes.include? recipe
      recipe.update_attributes(recipe_params)
      redirect_to recipe_path(recipe)
    else
      # if user tries to update recipe that doesn't belong to them
      # log them out
      session[:user_id] = nil
      redirect_to login_path
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    if current_user.recipes.include? recipe
      recipe.destroy
      redirect_to profile_path
    else
      # if user tries to destroy recipe that doesn't belong to them
      # log them out
      session[:user_id] = nil
      redirect_to login_path
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :instructions)
    end

end