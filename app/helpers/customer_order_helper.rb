module CustomerOrderHelper
  def bill_total(customer_order)
    return 0 unless customer_order.present?
    customer_order.products.sum(&:price)
  end
end
