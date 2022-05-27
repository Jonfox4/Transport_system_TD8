class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @vehicle = @shipping_company.vehicles.new
  end

  def create
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @vehicle = Vehicle.new(vehicles_params)
    @vehicle.shipping_company = @shipping_company
    if @vehicle.save
      redirect_to shipping_company_path(@shipping_company), notice: 'Veículo cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Veículo não cadastrado.'
      render 'new'
    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  private

  def vehicles_params
    params.require(:vehicle).permit(:plate, :brand, :vehicle_model, :fabrication_year)
  end
end
