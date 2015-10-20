class OrderMailer < ActionMailer::Base
  default from: 'essaystation101@gmail.com'

  def order_has_been_paid(order, user)
    @user = user
    @order = order
    @url  = 'http://essay.themindstudios.com'
    mail(to: @user.email, subject: 'Your order has been successfully paid')
  end

  def send_to_admin(admin, order, user)
    @user = user
    @order = order
    @admin = admin
    @url  = 'http://essay.themindstudios.com'
    mail(to: @admin.email, subject: "Order has been successfully paid by email #{@user.email}")
  end
end