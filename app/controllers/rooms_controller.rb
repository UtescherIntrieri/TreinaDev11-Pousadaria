class RoomsController < ApplicationController
  before_action :set_inn, only: [:show, :new, :create, :edit, :update, :destroy, :vacancy]
  before_action :authenticate, only: [:new, :edit]
  before_action :force_create_inn
  
  def show
    @room = Room.all.where(inn_id: @inn.id).find(params[:id])
  end
  
  def new
    @room = @inn.room.build()
  end

  def create
    @room = @inn.room.build(room_params)
    if @room.save()
      redirect_to inn_path(@inn.id), notice: 'Quarto cadastrado com sucesso.' 
    else
      flash.now[:notice] = 'Quarto não cadastrado.' 
      render 'new'
    end
  end
  
  def edit
    @room = Room.all.where(inn_id: @inn.id).find(params[:id])
  end
  
  def update
    @room = Room.all.where(inn_id: @inn.id).find(params[:id])
    if @room.update(room_params)
      redirect_to inn_room_path(@inn.id), notice: 'Quarto atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o quarto'
      render 'edit'
    end
  end
  
  def destroy
    @room = Room.all.where(inn_id: @inn.id).find(params[:id])
    @room.destroy
    redirect_to inn_path(@inn.id), notice: 'Quarto removido com sucesso'
  end
  
  def vacancy
    @room = Room.find(params[:id])
    if @room.status == 'full'
      @room.vacant!
    else
      @room.full!
    end
    redirect_to inn_room_path(@inn.id)
  end

  private

  def set_inn
    @inn = Inn.find(params[:inn_id])
  end

  def room_params
    room_params = params.require(:room).permit(:name, :description, :dimension, :capacity, :price, :bathroom, :balcony, :ac, :tv, :wardrobre, :safe_box, :accessible, :inn_id)
  end
end
