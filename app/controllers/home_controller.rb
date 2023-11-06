class HomeController < ApplicationController
  def index
    @inns = Inn.active
    @rooms = Room.vacant
  end
end