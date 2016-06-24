class SaleItem < ActiveRecord::Base
  include Monetizable

  # associations

  belongs_to :item
  belongs_to :sale

  # validations

  validates :item_id, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  def price=(money)
    unmasked = unmask_currency(money) if money.present?
    self[:price] = unmasked
  end

end
