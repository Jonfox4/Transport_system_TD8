class ShippingCompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @shipping_companies = ShippingCompany.all
    @shipping_company = current_user.shipping_company
  end

  def show
    @shipping_company = ShippingCompany.find(params[:id])
    @vehicles = @shipping_company.vehicles
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
