class DispatchLog < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :item, :user, :authorized_person, presence: true

  after_create :dispatch_item!

  def dispatch_item!
    item.dispatched!
  end
end
