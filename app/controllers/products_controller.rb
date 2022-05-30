class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @product = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Produto cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o produto.'
      render :new
    end
  end

  def show; end

  private

  def product_params
    params.require(:product).permit(:weight, :height, :width, :depth, :sku,
                                    :distance, :customer_address, :customer_name)
  end
end
