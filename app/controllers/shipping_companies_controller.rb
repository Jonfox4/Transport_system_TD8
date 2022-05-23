class ShippingCompaniesController < ApplicationController

  def index
    @shipping_companies = ShippingCompany.all
  end

  def show
    @shipping_company = ShippingCompany.find(params[:id])
  end

  def new
    @shipping_company = ShippingCompany.new
  end
 
  def create
    @shipping_company = ShippingCompany.new(shipping_company_params)

    if @shipping_company.save
      redirect_to @shipping_company, notice: 'Transportadora cadastrada com sucesso.'
    else
      flash.now[:alert] = 'Transportadora não cadastrada.'
      render 'new'
    end
  end

  private

  def shipping_company_params
      params.require(:shipping_company).permit(:brand_name, :corporate_name, :email_domain, :registration_number,
                                            :address, :city, :state)
  end

end
