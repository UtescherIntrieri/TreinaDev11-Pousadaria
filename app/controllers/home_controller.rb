class HomeController < ApplicationController
  def index
    @all_inns = Inn.all
    @last_3_inns = @all_inns.last(3).reverse
    @inns = @all_inns.order('brand_name').first(Inn.all.length - @last_3_inns.length)
    @rooms = Room.vacant
  end
end