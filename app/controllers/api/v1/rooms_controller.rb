class Api::V1::RoomsController < ActionController::API
  def show
    begin
      inn = Inn.find(params[:inn_id])
      rooms = Room.vacant.where(inn_id: inn.id)
      render status: 200, json: rooms.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404
    end
  end
  
  def index
    inn = Inn.find(params[:inn_id])
    rooms = Room.vacant.where(inn_id: inn.id)
    render status: 200, json: rooms.as_json(except: [:created_at, :updated_at])
  end
  
  def check
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:id])
    @adjusted_prices = AdjustedPrice.all.where(inn_id: @inn.id).where(room_id: @room.id)
    @reservation = @room.reservation.build()
    @reservation.arrive_date = Date.parse(params[:arrive_date])
    @reservation.leave_date = Date.parse(params[:leave_date])
    @reservation.group_size = params[:group_size]
    @reservation.total_price = 0
    @reservation.total_price = (@reservation.leave_date - @reservation.arrive_date).to_i * @room.price
    range1 = Range.new(@reservation.arrive_date, @reservation.leave_date)
    (@reservation.arrive_date..@reservation.leave_date).first((@reservation.leave_date - @reservation.arrive_date).to_i).each do |date|
      @adjusted_prices.each do |ap|
        range2 = Range.new(ap.start_date, ap.end_date)
        if date.to_date.between?(ap.start_date, ap.end_date)
          @reservation.total_price += ap.price - @room.price
        end
      end
    end
    test = @reservation.total_price * @reservation.group_size
    test2 = "nao"
    if @reservation.valid?
      render status: 200, json: test.as_json(except: [:created_at, :updated_at])
    else
      render json: {
        :errors => @reservation.errors
      }, status: 400
    end
  end
end