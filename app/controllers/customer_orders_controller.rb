class CustomerOrdersController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def cancel
    if customer_order.update_attribute(:canceled_at, Time.now)
      flash[:notice] = "You canceled order successful!"
      redirect_to(customer_orders_path)
    else 
      flash[:alert] = "You canceled order failure!"
      render('show')
    end
  end

  private
    def customer_order
      @customer_order ||= CustomerOrder.find(params[:id])
    end

    def customer_order_params
      params.require(:customer_order).permit(:user_id, :menu_id, :canceled_at)
    end
end 
