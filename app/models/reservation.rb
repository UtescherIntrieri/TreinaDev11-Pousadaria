class Reservation < ApplicationRecord
  validate :time_overlap
  enum status: { cancelled: 0, pending: 1, active: 2, finished: 3 }
  belongs_to :room

  private

  def time_overlap
    range1 = Range.new(arrive_date, leave_date)
    Reservation.not_cancelled.where(room_id: room_id).each do |reservation|
      range2 = Range.new(reservation.arrive_date, reservation.leave_date)
      errors.add(:arrive_date, "A data escolhida coincide com outra reserva: #{reservation.arrive_date.strftime("%d/%m/%y")} - #{reservation.leave_date.strftime("%d/%m/%y")}") if range1.overlaps?range2
    end
  end
end
