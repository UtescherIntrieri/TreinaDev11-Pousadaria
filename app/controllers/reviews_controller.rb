class ReviewsController < ApplicationController  
 

  def edit
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = @room.reservation.build()
  end

  def update
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.update reservation_params
      @reservation.save
      redirect_to inn_room_reservation_path(@inn.id, @room.id, @reservation.id), notice: 'Resposta enviada com sucesso.' 
    else
      flash.now[:notice] = 'Resposta não enviada.' 
      render 'reservations/show'
    end
  end
end