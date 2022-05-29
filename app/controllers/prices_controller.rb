class PricesController < ApplicationController

  def index
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @prices = @shipping_company.prices
  end

  def new
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @price = @shipping_company.prices.new
  end

  def create
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @price = @shipping_company.prices.new(price_params)
    if @price.save
      redirect_to shipping_company_prices_path(@shipping_company), notice: 'Precificação cadastrada com sucesso'
    else
      flash.now[:alert] = 'Erro ao cadastrar precificação.'
      render :new
    end
  end

  private

  def price_params
    params.require(:price).permit(:maximum_weight, :minimum_weight, :maximum_cubic_meter, :maximum_cubic_meter, :maximum_cubic_meter,
                                  :minimum_cubic_meter, :price_km)
  end

end
