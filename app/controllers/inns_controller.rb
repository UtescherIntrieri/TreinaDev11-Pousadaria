class InnsController < ApplicationController
  before_action :set_inn, only: [:show, :edit, :update, :inn_reviews]
  before_action :force_create_inn, except: [:new, :create, :edit, :update]

  def show
    @rooms = Room.vacant.where(inn_id: @inn.id)
    @reservations = Reservation.where.not(rating: nil)
    @res = @reservations.where(room_id: @rooms.ids).last(3)
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

  def search
    @brand_name = params["brand_name"]
    @neighborhood = params["neighborhood"]
    @city = params["city"]
    @pet_friendly = params["pet_friendly"]
    @capacity = params["capacity"]
    @bathroom = params["bathroom"]
    @balcony = params["balcony"]
    @ac = params["ac"]
    @tv = params["tv"]
    @wardrobre = params["wardrobre"]
    @safe_box = params["safe_box"]
    @accessible = params["accessible"]
    @rooms = Room.vacant
    @rooms = @rooms.where(capacity: @capacity) unless params["capacity"].blank?
    @rooms = @rooms.where(bathroom: @bathroom) unless params["bathroom"].blank?
    @rooms = @rooms.where(balcony: @balcony) unless params["balcony"].blank?
    @rooms = @rooms.where(ac: @ac) unless params["ac"].blank?
    @rooms = @rooms.where(tv: @tv) unless params["tv"].blank?
    @rooms = @rooms.where(wardrobre: @wardrobre) unless params["wardrobre"].blank?
    @rooms = @rooms.where(safe_box: @safe_box) unless params["safe_box"].blank?
    @rooms = @rooms.where(accessible: @accessible) unless params["accessible"].blank?
    @inns = Inn.active
    @inns = @inns.where(id: @rooms.where(capacity: @capacity).pluck(:inn_id)) unless params["capacity"].blank?
    @inns = @inns.where(id: @rooms.where(bathroom: @bathroom).pluck(:inn_id)) unless params["bathroom"].blank?
    @inns = @inns.where(id: @rooms.where(balcony: @balcony).pluck(:inn_id)) unless params["balcony"].blank?
    @inns = @inns.where(id: @rooms.where(ac: @ac).pluck(:inn_id)) unless params["ac"].blank?
    @inns = @inns.where(id: @rooms.where(tv: @tv).pluck(:inn_id)) unless params["tv"].blank?
    @inns = @inns.where(id: @rooms.where(wardrobre: @wardrobre).pluck(:inn_id)) unless params["wardrobre"].blank?
    @inns = @inns.where(id: @rooms.where(safe_box: @safe_box).pluck(:inn_id)) unless params["safe_box"].blank?
    @inns = @inns.where(id: @rooms.where(accessible: @accessible).pluck(:inn_id)) unless params["accessible"].blank?
    @inns = @inns.where("brand_name LIKE ?", "%#{@brand_name}%") unless params["brand_name"].blank?
    @inns = @inns.where("neighborhood LIKE ?", "%#{@neighborhood}%") unless params["neighborhood"].blank?
    @inns = @inns.where("city LIKE ?", "%#{@city}%") unless params["city"].blank?
    @inns = @inns.where(pet_friendly: @pet_friendly) unless params["pet_friendly"].blank?
  end

  def city_search
    @rooms = Room.vacant
    @city = params["query"]
    @inns = Inn.active.order('brand_name').where("city LIKE ?", "%#{@city}%")
  end
  
  def adv_search
    @rooms = Room.vacant
    @inns = Inn.active
  end

  def inn_reviews
    @rooms = Room.vacant.where(inn_id: @inn.id)
    @reservations = Reservation.where.not(rating: nil)
    @res = @reservations.where(room_id: @rooms.ids)
  end

  private

  def set_inn
    @inn = Inn.find(params[:id])
  end

  def inn_params
    inn_params = params.require(:inn).permit(:corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, :city, :state, :postal_code, :description, :payment_methods, :pet_friendly, :usage_policy, :check_in, :check_out, :host_id)
  end
end