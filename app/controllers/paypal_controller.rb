class PaypalController < ApplicationController
  include PaypalHelper

  def checkout
    order = Order.find(params[:id])
    total_as_cents, setup_purchase_params = get_setup_purchase_params order, request
    setup_response = EXPRESS_GATEWAY.setup_purchase(total_as_cents, setup_purchase_params)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(setup_response.token)
  end

  def get_token
    @order = Order.find(params[:id])
    if params[:token].nil?
      redirect_to step_three_path(@order.public_id), :notice => 'Woops! Something went wrong!'
    else
      if @order.purchase(params) # this is where we purchase the order. refer to the model method below
        @order.payment_success!
        @order.update_deadline
        begin
          OrderMailer.order_has_been_paid(@order, current_user).deliver #send email about paid
          User.send_email_to_admin(@order, current_user) #send email to all admins about paid
        rescue Net::SMTPAuthenticationError => msg
          logger.fatal msg
        ensure
          redirect_to success_path(@order)
        end
      else
        redirect_to step_three_path(@order), :notice => 'Woops! Something went wrong! Please, try again.'
      end
    end
  end

end