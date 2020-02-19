require 'csv'

module Products
  class Importor < ImportCsv
    attr_accessor :category, :product

    def perform
      return false unless csv_valid?
      CSV.foreach(@file.path, headers: true) do |row|
        product(row).save ? @success += 1 : @failure += 1
      end
      success?
    end

    private

    def product(row)
      product = Product.new
      product.name = row['name']
      product.description = row['description']
      product.price = row['price']
      product.quatity = row['quatity']
      product.category = category(row['category'])
      product
    end

    def category(category_name)
      @category ||= Category.find_or_create_by(name: category_name)
    end
  end
end
