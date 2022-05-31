class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @shipping_companies = ShippingCompany.all
    @vehicles = Vehicle.all
    @product = Product.all
  end

  def create
    order_params = params.require(:order).permit(:shipping_company_id, :vehicle_id, :product_model_id, :customer_address, :customer_name, :estimated_delivery_date, :status)
    @order = Order.new(order_params)
    if @order.save
      redirect_to order_path, notice: 'Ordem de serviço registrada com sucesso.'
    else
      @shipping_companies = ShippingCompany.all
      @vehicles = Vehicle.all
      @product = Product.all
      flash.now[:notice] = 'Erro ao criar ordem de serviço.'
    render 'new'
    end
  end

  def accept
    @order = Order.find(params[:id])
    @order.accept!
    redirect_to order_path(@order.id), notice: 'Pedido aceito com sucesso!'
  end

  def recused
    @order = Order.find(params[:id])
    @order.recused!
    redirect_to order_path(@order.id), notice: 'Pedido recusado com sucesso!'
  end
end
