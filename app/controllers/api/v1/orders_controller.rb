class Api::V1::OrdersController < Api::V1::ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @orders = Order.all
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def create
    @order = Order.new(order_params.except(:line_items))
    @customer = Customer.find(params[:customer_id])
    order_params[:line_items].each do |line_item_params|
      item_price, item_discount, line_item_disc = LineItem.calculate_item_prices(line_item_params)
      line_item_params[:disc] = line_item_disc
      @order.line_items.build(line_item_params)
    end

    respond_to do |format|
      if @order.save!
        delay_time = 10.minutes
        OrderStatusUpdateJob.set(wait: delay_time).perform_later(@order)

        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render json: @order, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orderss_url, notice: "Order was successfully destroyed." }
      format.json { render json: @order }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.permit(:customer_id, :order_number, :status, line_items: [:item_id, :group_item_id, :promotion_line_item_id, :quantity, :price, :disc])
    end
end
