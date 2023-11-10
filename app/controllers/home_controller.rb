class HomeController < ApplicationController
  def index
    @last_3_inns = Inn.last(3).reverse
    @inns = Inn.order('brand_name').first(Inn.all.length - @last_3_inns.length)
    @rooms = Room.vacant
  end
end