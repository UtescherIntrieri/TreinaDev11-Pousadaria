class InnsController < ApplicationController
  def show
    @inn = Inn.find(params[:id])
  end

  def new
    @inn = Inn.new()
  end

  def create
    inn_params =     params.require(:inn).permit(:corporate_names, :brand_name, :registration_number, :phone_number, :phone_number, :email, :address, :neighborhood, :city, :state, :postal_code, :description, :payment_methods, :pet_friendly, :usage_policy, :check_in, :check_out)
    @inn = Inn.new(inn_params)
    if @inn.save()
      redirect_to root_path, notice: 'Pousada cadastrada com sucesso.' 
    else
      flash.now[:notice] = 'Pousada não cadastrada.' 
      render 'new'
    end
  end
end