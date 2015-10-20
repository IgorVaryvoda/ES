class OrdersController < ApplicationController

  def show
    if Order.find(params[:id]).user.id == current_user.id
      @order = Order.find(params[:id])
    else
      redirect_to orders_list_path
    end
  end

  def create
    @order = Order.new(order_params)
    @order.price = Order.calculate_price(params[:order])
    @order.deadline = Order.set_deadline(params[:order])
    if user_signed_in?
      @order.user_id = current_user.id
    end
    if @order.save
      redirect_to step_two_path(@order.public_id)
    else
      render 'welcome/index', flash[:error] = @order.errors.messages
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if params[:resources].present?
        params[:resources][:document].each do |document|
          @order.resources.create(document: document)
        end
      end
      redirect_to step_three_path(@order.public_id)
    else
      render 'orders/step_two'#, flash[:error] = @order.errors.messages
    end
  end

  def step_two
    @order = Order.find_by_public_id(params[:public_id])
    @authors = Author.all.sample(rand(6..10))
  end

  def step_three
    @order = Order.find_by_public_id(params[:public_id])
    if user_signed_in?
      if @order.user_id.nil?
        @order.user_id = current_user.id
        @order.save
      end
      session[:current_order_public_id] = nil
      redirect_to order_path(@order) if !@order.aasm_state.include?'new_order'
    else
      @user = User.new
      session[:current_order_public_id] = @order.public_id
    end
  end

  def calculate_order
    price = Order.calculate_price(params[:order])
    return render :json => {:text => "Total price: $#{price.to_s}", :price => price}
  end

  def success
    if Order.find(params[:id]).user.id == current_user.id
      @order = Order.find(params[:id])
    else
      redirect_to orders_list_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:price, :type_of_paper, :academic_level, :pages, :deadline, :topic, :discipline, :details)
  end

end