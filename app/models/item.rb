class Item < ActiveRecord::Base
  include Monetizable

  # association

  belongs_to :user

  # enums

  enum status: [ :available, :unavailable ]

  # validations

  validates :cost_price, presence: true
  validates :name, presence: true
  validates :quantity, presence: true
  validates :status, presence: true
  validates :unitary_price, presence: true
  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user_id: user)
  end

  # class methods

  def self.status_str(status)
    if statuses.include?(status)
      I18n.t("activerecord.attributes.item.statuses.#{status}")
    else
      I18n.t(:undefined)
    end
  end

  def cost_price=(money)
    unmasked = unmask_currency(money) if money.present?
    self[:cost_price] = unmasked
  end

  def unitary_price=(money)
    unmasked = unmask_currency(money) if money.present?
    self[:unitary_price] = unmasked
  end

end
