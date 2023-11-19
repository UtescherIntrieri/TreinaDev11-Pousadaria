class AdjustedPrice < ApplicationRecord
  validate :time_overlap
  belongs_to :room

  private

  def time_overlap
    range1 = Range.new(start_date, end_date)
    AdjustedPrice.where(inn_id: inn_id, room_id: room_id).each do |ap|
      range2 = Range.new(ap.start_date, ap.end_date)
      errors.add(:start_date, "O Período coincide com outro já cadastrado: #{ap.start_date.strftime("%d/%m/%y")} - #{ap.end_date.strftime("%d/%m/%y")}") if range1.overlaps?range2
    end
  end
end
