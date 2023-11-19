class AdjustedPricesController < ApplicationController
  before_action :set_adjusted_price, only: [:show, :edit, :update, :destroy]
  before_action :force_create_inn

  def index
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @adjusted_prices = AdjustedPrice.all.where(inn_id: @inn.id).where(room_id: @room.id)
    authenticate
  end

  def show
  end

  def new
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @adjusted_price = @room.adjusted_price.build()
    authenticate
  end
  
  def create
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @adjusted_price = @room.adjusted_price.build(adjusted_price_params)
    if @adjusted_price.save()
      redirect_to inn_room_adjusted_prices_path(@inn.id, @room.id), notice: 'Preço por periodo cadastrado com sucesso.' 
    else
      flash.now[:notice] = 'Preço por periodo não cadastrado.' 
      render 'new'
    end
  end
  
  def edit
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    authenticate
  end
  
  def update
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    if @adjusted_price.update(adjusted_price_params)
      redirect_to inn_room_adjusted_prices_path(@inn.id, @room.id), notice: 'Periodo atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o periodo'
      render 'edit'
    end
  end
  
  def destroy
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @adjusted_price.destroy
    redirect_to inn_room_adjusted_prices_path(@inn.id, @room.id), notice: 'Periodo removido com sucesso'
  end
  
  private
  
  def set_adjusted_price
    @adjusted_price = AdjustedPrice.find(params[:id])
  end

  def adjusted_price_params
    adjusted_price_params = params.require(:adjusted_price).permit(:price, :start_date, :end_date, :room_id, :inn_id)
  end
end