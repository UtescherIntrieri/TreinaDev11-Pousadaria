class HostsController < ApplicationController
  before_action :force_create_inn

  def show
    @host = Host.find(params[:id])
    @inn = Inn.find_by host_id: @host.id
    @rooms = Room.all.where(inn_id: @inn.id) if @inn.present?
    redirect_to(root_path) unless host_signed_in? && current_host.id == @host.id
  end

end