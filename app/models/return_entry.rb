class ReturnEntry < ApplicationRecord
  belongs_to :item, foreign_key: 'item_code', primary_key: 'code', optional: true

  before_validation :set_item_code

  validates :item_code, presence: true
  def set_item_code
    raise raise ActiveRecord::RecordNotFound unless ReserveLog.find_by!(request_number: request_number)
    self.item_code = ReserveLog.find_by(request_number: request_number).item.code
  end
end
