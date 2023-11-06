class AdjustedPrice < ApplicationRecord
  validate :time_overlap
  belongs_to :room

  private

  def time_overlap
    range1 = Range.new(start_date, end_date)
    AdjustedPrice.all.each do |ap|
      range2 = Range.new(ap.start_date, ap.end_date)
      errors.add(:start_date, "overlap :)") if range1.overlap?range2
    end
  end
end
