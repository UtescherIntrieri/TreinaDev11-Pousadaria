class HomeController < ApplicationController
  def index
    @inns = Inn.active
  end
end