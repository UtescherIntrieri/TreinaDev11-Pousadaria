class InnsController < ApplicationController
  before_action :set_inn, only: [:show, :edit, :update]
  before_action :force_create_inn, except: [:new, :create, :edit, :update]

  def show
    @rooms = Room.vacant.where(inn_id: @inn.id)
  end

  def new
    @inn = Inn.new()
  end

  def create
    @inn = Inn.new(inn_params)
    if @inn.save()
      redirect_to root_path, notice: 'Pousada cadastrada com sucesso.' 
    else
      flash.now[:notice] = 'Pousada não cadastrada.' 
      render 'new'
    end
  end

  def edit
    authenticate
  end
  
  def update
    if @inn.update(inn_params)
      redirect_to inn_path(@inn.id), notice: 'Pousada atualizada com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar a pousada'
      render 'edit'
    end
  end

  def activate
    @inn = Inn.find(params[:id])
    if @inn.status == 'inactive'
      @inn.active!
    else
      @inn.inactive!
    end
    redirect_to inn_path(@inn.id)
  end

  def city_search
    @rooms = Room.vacant
    @city = params["query"]
    @inns = Inn.order('brand_name').where("city LIKE ?", "%#{@city}%")
  end

  private

  def set_inn
    @inn = Inn.find(params[:id])
  end

  def inn_params
    inn_params = params.require(:inn).permit(:corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, :city, :state, :postal_code, :description, :payment_methods, :pet_friendly, :usage_policy, :check_in, :check_out, :host_id)
  end
end