class PagesController < ApplicationController

  def how_it_works
    @order = Order.new
  end

  def about_us
    @order = Order.new
  end

  def faq
    @order = Order.new
  end

  def our_writers
    @order = Order.new
    @authors = Author.first(7)
  end

  def contact_us
    @order = Order.new
  end

end