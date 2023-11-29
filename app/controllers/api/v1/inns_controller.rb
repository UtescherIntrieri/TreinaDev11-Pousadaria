class Api::V1::InnsController < ActionController::API
  def show
    begin
      inn = Inn.find(params[:id])
      rooms = Room.where(inn_id: inn.id)
      reservations = Reservation.where(room_id: rooms.ids).where.not(rating: nil)
      if reservations.any?
        avg_rating = 0
        reservations.each do |res|
          avg_rating += res.rating
        end
        avg_rating = avg_rating / reservations.length
      else
        avg_rating = ""
      end
      final_view = [inn, {"average_rating" => avg_rating}]
      render status: 200, json: final_view.as_json(except: [:created_at, :updated_at, :registration_number, :brand_name])
    rescue
      render status: 404
    end
  end
  
  def index
    inns = Inn.active
    inns = inns.where("inns.brand_name LIKE ?", "%#{params[:brand_name]}") if params[:brand_name].present?
    render status: 200, json: inns.as_json(except: [:created_at, :updated_at, :registration_number, :brand_name])
  end
end