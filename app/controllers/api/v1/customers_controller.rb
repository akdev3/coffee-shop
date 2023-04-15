class Api::V1::CustomersController < Api::V1::ApplicationController
  before_action :set_customer, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  def index
    @customers = Customer.all
    respond_to do |format|
      format.html
      format.json { render json: @customers }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @customer }
    end
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully created." }
        format.json { render json: @customer, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: "Customer was successfully updated." }
        format.json { render json: @customer, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { render json: @customer }
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name, :email)
    end
end
