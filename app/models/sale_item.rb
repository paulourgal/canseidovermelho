class SaleItem < ActiveRecord::Base

  # associations

  belongs_to :item
  belongs_to :sale

  # validations

  validates :item_id, presence: true
  validates :price, presence: true

end
