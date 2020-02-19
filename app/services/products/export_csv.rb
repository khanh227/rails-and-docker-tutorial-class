require 'csv'

module Products
  class ExportCsv
    def initialize(products)
      @products = products
    end

    def perform
      CSV.generate do |csv|
        csv << header
        @products.each do |product|
          csv << csv_row(product)
        end
      end
    end

    private
    def header
      header = ['Name', 'Description', 'Price', 'Enabled', 'Quatity']
    end

    def csv_row(product)
      csv_row = []
      csv_row << product.name
      csv_row << product.description
      csv_row << product.price
      csv_row << product.enabled
      csv_row << product.quatity
    end
  end
end
