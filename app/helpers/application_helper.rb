module ApplicationHelper

  def currency(value)
    number_with_precision(value.to_f, precision: 2)
  end

end
