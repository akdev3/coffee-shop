class Api::V1::LineItemsController < Api::V1::ApplicationController
  before_action :set_line_item, only: %i[ show update destroy ]
  before_action :set_order, only: %i[ create update ]
  before_action :set_line_item_params, only: %i[ update ]

  skip_before_action :verify_authenticity_token

  def index
    @line_items = LineItem.all
    respond_to do |format|
      format.html
      format.json { render json: @line_items }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @line_item }
    end
  end

  def create
    @line_item = @order.line_items.build(line_item_params)
    item_price, line_item_disc = LineItem.calculate_item_prices(@line_item)

    @line_item.price = item_price
    @line_item.disc = line_item_disc

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to item_url(@line_item), notice: "Line Item was successfully created." }
        format.json { render json: @line_item, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(@updated_line_item_params)
        format.html { redirect_to @line_item, notice: "Line Item was successfully updated." }
        format.json { render json: @line_item, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Line Item was successfully destroyed." }
      format.json { render json: @line_item }
    end
  end

  private
    def set_order
      @order = Order.find(params[:order_id])
    end

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:item_id, :group_item_id, :promotion_line_item_id, :quantity, :disc, :order_id)
    end

    def set_line_item_params
      item_price, line_item_disc = LineItem.calculate_item_prices(@line_item)

      @updated_line_item_params[:price] = item_price
      @updated_line_item_params[:disc] = line_item_disc
    end
end
