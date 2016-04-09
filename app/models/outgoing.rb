class Outgoing < ActiveRecord::Base

  # assossiations

  belongs_to :user

  # enums

  enum kind: [ :feeding, :rent, :car, :other ]

  # validations

  validates :day, presence: true
  validates :kind, presence: true
  validates :user_id, presence: true
  validates :value, presence: true

  # scopes

  def self.by_user(user)
    where(user: user)
  end

  def self.kind_str(kind)
    if kinds.include?(kind)
      I18n.t("activerecord.attributes.outgoing.kinds.#{kind}")
    else
      I18n.t(:undefined)
    end
  end


  def value=(money)
    unmasked = unmask_currency(money) if money.present?
    self[:value] = unmasked
  end

  protected

  def unmask_currency(money)
    unmasked = money
    if money.is_a?(String)
      unmasked = money[3..-1] if money[0..2] == 'R$ '
      unmasked = unmasked.to_s.delete('.').delete(',')
      unmasked.insert(-3, '.')
    end
    unmasked.to_f
  end

end
