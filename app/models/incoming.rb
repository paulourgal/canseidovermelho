class Incoming < ActiveRecord::Base
  include Monetizable

  # associations

  belongs_to :category
  belongs_to :user

  # delegations

  delegate :name, to: :category, prefix: true

  # validations

  validates :category_id, presence: true
  validates :day, presence: true
  validates :user_id, presence: true
  validates :value, presence: true

  # scopes

  def self.by_user(user)
    where(user: user)
  end

  def value=(money)
    unmasked = unmask_currency(money) if money.present?
    self[:value] = unmasked
  end

end
