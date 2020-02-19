class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html { display_products }
      format.csv { export_products }
    end
  end

  def display_products
    @products = @products.order(created_at: :desc)
  end

  def export_products
    send_data(
      Products::ExportCsv.new(display_products).perform,
      type: 'text/csv',
      filename: 'products.csv',
      disposition: 'attachment'
      )
  end

  def new
    @product = Product.new
  end

  def show
    @product
  end

  def edit
    @product
  end

  def create
    @product = Product.new(product_params.merge(user_id: current_user.id))
    redirect_to @product if @product.save
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to products_path if @product.destroy
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price, :enabled, :quatity, :user_id, :category_id)
    end
end
