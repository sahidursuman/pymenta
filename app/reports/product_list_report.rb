class ProductListReport < PdfReport
  TABLE_WIDTHS = [50, 200, 60, 120]
  RAILS_ROOT = Rails.root

  def initialize(products=[],user)
    super()
    @products = products
    @user = user

    logo
    header 'Product List Report'
    display_product_table
    footer
  end

  private

  def logo
    image "#{RAILS_ROOT}/public"+@user.company.logo.url(:square).sub(/\?.+\Z/, ''), :width => 250, :height => 100
  end

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