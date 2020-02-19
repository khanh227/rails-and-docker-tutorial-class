class CategoriesController < ApplicationController
  load_and_authorize_resource
  
  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    @category.save ? redirect_to(categories_path) : render('new')
  end

  def update
    @category.update(category_params) ? redirect_to(categories_path) : render('edit')
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :enabled)
    end
end 
