module Monetizable
  extend ActiveSupport::Concern

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
