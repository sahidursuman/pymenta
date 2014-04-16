class ProductListReport < PdfReport
  TABLE_WIDTHS = [50, 200, 60, 120]

  def initialize(products=[])
    super()
    @products = products

    header 'Product List Report'
    display_product_table
    footer
  end

  private

  def display_product_table
    if table_data.empty?
      text "No Products Found"
    else
      table(table_data,column_widths: TABLE_WIDTHS)
    end
  end

  def table_data
    @table_data ||= @products.map { |e| [e.code, e.description, e.brand.description, e.category.description, e.price] }
  end

end