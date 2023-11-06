class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def force_create_inn
    redirect_to(new_inn_path) if host_signed_in? && Inn.all.where(host_id: current_host.id).empty?
  end

  def authenticate
    redirect_to(root_path) unless host_signed_in? && current_host.id == @inn.host_id
  end
end
