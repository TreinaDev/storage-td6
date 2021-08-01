class ReturnLog < ApplicationRecord
  belongs_to :return_entry

  enum decision: { waiting: 0, discarted: 5, approved: 10 }

  has_many_attached :picture
  after_create :return_item_to_stock
  after_create :put_item_on_discart

  validates :justification, :date, :picture, presence: true

  private

  def return_item_to_stock
    return unless approved?

    item = ReturnEntry.find(return_entry_id).item
    item.available!
    item.save
  end

  def put_item_on_discart
    return unless discarted?

    item = ReturnEntry.find(return_entry_id).item
    item.discarted!
    item.save
  end
end
