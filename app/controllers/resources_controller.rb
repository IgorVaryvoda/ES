class ResourcesController < ApplicationController

  def upload
    @order = Order.find(params[:id])
    @order.resources << Resource.create(res_params)
  end

  private

  def res_params
    params.require(:resource).permit(:document)
  end

end