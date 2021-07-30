class ReturnEntry < ApplicationRecord
  belongs_to :item, foreign_key: 'item_code', primary_key: 'code', optional: true, inverse_of: :return_entries

  has_many :warehouses, through: :items
  has_many :return_logs, dependent: :destroy

  before_validation :set_item_code

  validates :item_code, presence: true

  def set_item_code
    code = ReserveLog.find_by!(request_number: request_number).item.code
    self.item_code = code
  end
end
