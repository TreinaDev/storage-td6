class ReturnLog < ApplicationRecord
  belongs_to :return_entry

  enum decision: { waiting: 0, discarted: 5, approved: 10 }

  has_many_attached :picture
  after_create :return_item_to_stock

  validates :justification, :date, :picture, presence: true
  def self.human_enum_name(enum_name, enum_value)
    enum_i18n_key = enum_name.to_s.pluralize
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_i18n_key}.#{enum_value}")
  end

  private

  def return_item_to_stock
    return unless approved?

    item = ReturnEntry.find(return_entry_id).item
    item.available!
  end
end
