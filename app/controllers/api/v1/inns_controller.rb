class Api::V1::InnsController < ActionController::API
  def show
    begin
      inn = Inn.find(params[:id])
      rooms = Room.all.where(inn_id: inn.id)
      render status: 200, json: rooms.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404
    end
  end
  
  def index
    inns = Inn.active
    render status: 200, json: inns.as_json(except: [:created_at, :updated_at])
  end
end